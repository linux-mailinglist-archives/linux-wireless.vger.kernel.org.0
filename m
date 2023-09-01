Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6378F898
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347098AbjIAGc7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIAGc6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:32:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85010E3;
        Thu, 31 Aug 2023 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H116kV/R/7uTokMSgYXJpYx9/1xYyOt6dtXYBUSNA6w=;
        t=1693549972; x=1694759572; b=RfDxFMeagUevdQcy+WxE8PI792Lv6a3TPaZSYorTq60Fzma
        PKRESxdgjRjW/sbay1gv8IIni81GgYWRjHGAWaqOJ420c4Bj7DI6oxXke5x0jN2agod9qV3EZsFLN
        5qQi8IkLiwO9GpXgZIvQBYe2fCyIWkE9B0STJiTtjiMzAZcezNuLXMjKKES24YPc7gE1RHqrzkNQ2
        pP8YNDirk2gI0Tkmp/BjpVg6q6KqtrOz+bJ+Yi53PMZWaRYfIuD4tUXskJAguvBk5S5jAiwFzYE8m
        0xetdDW2XkWCldthwEB7xhVQqNiNqbbUazwS8Dpg4Qo8wkuqAh1adattUmAaSa9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qbxi2-006dEK-2K;
        Fri, 01 Sep 2023 08:32:47 +0200
Message-ID: <7127fe5a4f2cfcdc3a55269f0a427477e264fabc.camel@sipsolutions.net>
Subject: Re: [PATCH net,v2] wifi: mac80211: fix WARNING in
 ieee80211_link_info_change_notify()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com
Date:   Fri, 01 Sep 2023 08:32:45 +0200
In-Reply-To: <20230901035301.3473463-1-shaozhengchao@huawei.com>
References: <20230901035301.3473463-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-09-01 at 11:53 +0800, Zhengchao Shao wrote:
>=20
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 24315d7b3126..f79e2343dddd 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -285,6 +285,9 @@ void ieee80211_link_info_change_notify(struct ieee802=
11_sub_if_data *sdata,
>  	if (!changed || sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN)
>  		return;
> =20
> +	if (!ieee80211_sdata_running(sdata))
> +		return;
> +
>  	if (!check_sdata_in_driver(sdata))
>  		return;
>=20

I don't think this is right. Do you see anything else checking that it's
running right before checking it's in the driver? :)

Why can we even get into this call at all? I think the problem is
already in cfg80211 allowing this.

johannes=20

