Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958494FBD25
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbiDKNeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346520AbiDKNeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 09:34:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511A3BBDB
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bDZga5W4ByKTW3fjpHFc5Pr78Sw6vXoCobwjKct//1g=;
        t=1649683913; x=1650893513; b=rVIG3GsSEjYojQUpO+A3KsXro9e1FyODGPvJDgMowp2uGGA
        CNveGmFsBlMKFbDbBR0r/vdm8oRdpAwSjDp/OaOYdlKbJrnXxiA01yhRPzkVWrUmEigjakdbXl+a6
        VoDbmhTvF08DmC31tM3cRP+nYdT6QXhtZTcWZVcdYqBZVuSVJRVKOOKhwVKxh8bIqsFyaq0G1PC+g
        BMT8J0oGIgz/0toCGh334hQIjbY8/FvdFOIe1KKYx/J4yc8ZCRG4m5aH+d141Wphyp1rIvtiCNHDx
        lNWzb8oY532pABV25aPg2KYfST1ly6bz7iUxTqN1pFq1SeiX69Vs+tIOCIc1Nhog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ndu90-008ItI-HA;
        Mon, 11 Apr 2022 15:31:50 +0200
Message-ID: <27b8b92f8fe9883d808a9412370bf23386165482.camel@sipsolutions.net>
Subject: Re: [PATCH v4] mac80211: disable BSS color collision detection in
 case of no free colors
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
Date:   Mon, 11 Apr 2022 15:31:49 +0200
In-Reply-To: <1648195961-3811-1-git-send-email-quic_ramess@quicinc.com>
References: <1648195961-3811-1-git-send-email-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-03-25 at 13:42 +0530, Rameshkumar Sundaram wrote:


> +	he_bss_color->color =
> +		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
> +	he_bss_color->enabled =
> +		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
> +	he_bss_color->partial =
> +		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
> +
> +	return 0;
> +}
> +
>  static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
>  				struct nlattr *attrs[],
>  				struct cfg80211_beacon_data *bcn)
> @@ -5204,6 +5228,12 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
>  		bcn->ftm_responder = -1;
>  	}
>  
> +	if (attrs[NL80211_ATTR_HE_BSS_COLOR]) {
> +		err = nl80211_parse_he_bss_color(attrs[NL80211_ATTR_HE_BSS_COLOR],
> +						 &bcn->he_bss_color);
> +		if (err)
> +			return err;
> +	}

Could use a newline after this.

But not sure I get it - doesn't that always disable BSS coloring now if
you do a beacon update that didn't include the attribute? Did hostapd
always include it in the past?

johannes
