Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3E4FBD2E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbiDKNfg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiDKNfe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 09:35:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1573BA74
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WUGxB8hMo9/IEkGrBH+7zuIT/oxpKDEXRjd9tYKej+I=;
        t=1649684000; x=1650893600; b=vqfN3RlL4xnE3N8fXAPe3TI7rkJijyNzk+6l5rWOgMHk5Jg
        UscJQ53xwQ7EzQhscgMb4ee9jbk7qDHAUWJnDRz93hWomT1M+ngT3GLrF5iNqNIo9Szfr+Tww6VId
        rQ+klQQT31jqs6oCfB+XvZrJgfSsw9uwriJzrmTC5vSbMAHrsHD/FOuL5U0WoJGXZ2FMHtdj+5bRJ
        +2FxHD4z+3eXMn/PwFR52GGSllj8wb7F9zNnKTdnzYjEXd0jX+G4EUgwDdoRiBjDA0STELt6cf2Ik
        kRU2CFZy1z2XmGmx0dPMvU7eggr7iaU2cbYwiOojQ2UzMbXBCSW8KQdS9c8r4hjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nduAQ-008IvC-VU;
        Mon, 11 Apr 2022 15:33:19 +0200
Message-ID: <08ff262491040268a6e6b0da0ad32707f091ff2d.camel@sipsolutions.net>
Subject: Re: [PATCH v4] mac80211: disable BSS color collision detection in
 case of no free colors
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:33:18 +0200
In-Reply-To: <27b8b92f8fe9883d808a9412370bf23386165482.camel@sipsolutions.net>
References: <1648195961-3811-1-git-send-email-quic_ramess@quicinc.com>
         <27b8b92f8fe9883d808a9412370bf23386165482.camel@sipsolutions.net>
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

On Mon, 2022-04-11 at 15:31 +0200, Johannes Berg wrote:
> On Fri, 2022-03-25 at 13:42 +0530, Rameshkumar Sundaram wrote:
> 
> 
> > +	he_bss_color->color =
> > +		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
> > +	he_bss_color->enabled =
> > +		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
> > +	he_bss_color->partial =
> > +		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
> > +
> > +	return 0;
> > +}
> > +
> >  static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
> >  				struct nlattr *attrs[],
> >  				struct cfg80211_beacon_data *bcn)
> > @@ -5204,6 +5228,12 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
> >  		bcn->ftm_responder = -1;
> >  	}
> >  
> > +	if (attrs[NL80211_ATTR_HE_BSS_COLOR]) {
> > +		err = nl80211_parse_he_bss_color(attrs[NL80211_ATTR_HE_BSS_COLOR],
> > +						 &bcn->he_bss_color);
> > +		if (err)
> > +			return err;
> > +	}
> 
> Could use a newline after this.
> 
> But not sure I get it - doesn't that always disable BSS coloring now if
> you do a beacon update that didn't include the attribute? Did hostapd
> always include it in the past?
> 

Seems like we should track whether it was actually included, and only if
the attribute was included then mac80211 knows - ie. have something like

 struct cfg80211_beacon_data {
  ...
+	struct cfg80211_he_bss_color he_bss_color;
+	bool he_bss_color_valid;

or so?
