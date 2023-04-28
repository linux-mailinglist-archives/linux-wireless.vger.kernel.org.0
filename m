Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3F6F1E29
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346517AbjD1SmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbjD1SmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 14:42:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDCE1FEB
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rI9YjSYporZwQ/Z29ciG40cmBGqz8bYjrXtFm3OicjY=;
        t=1682707319; x=1683916919; b=Eei27pxTa5KYOOIS7qE+LEy56aXVQm4iMP68u9mcG5Nkafu
        Y33EXSTxr5GI3Hp1gohXwA3GQW7XbxS/heHnFrzG0BkJCw4tsycoVMg0XNKrlP+5cdnKTdezQU7a4
        ZjOoDl22SCJU2HA2X6PWg5BgNo8HEwfV8jbnSZhrs4TwUts7BE3PCob1Zrgy6r32E5Dvsxk59KoBb
        x1pNMEBCuBvsYaduLMow5HmNWJy7eqoxheJFaD/0VKFnlui/c0kHC9VGWhyBep8rqVEt3cpUZpiQ4
        kcMN9IJqR3kCyDIp1vNMDdgwpAKulVjYnlPEQqmXrSsCOuSPz4tMrKAO8p4537yw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1psT2Y-00BKpO-1d;
        Fri, 28 Apr 2023 20:41:54 +0200
Message-ID: <431b8d98c2e5d81c20862965151ac63596f04bf3.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Remove driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 28 Apr 2023 20:41:53 +0200
In-Reply-To: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
References: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-04-28 at 13:29 -0500, Larry Finger wrote:
> --- a/drivers/net/wireless/realtek/rtlwifi/core.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/core.c
> @@ -1770,12 +1770,6 @@ static void rtl_op_flush(struct ieee80211_hw *hw,
> =C2=A0static int rtl_op_set_tim(struct ieee80211_hw *hw, struct ieee80211=
_sta *sta,
> =C2=A0			=C2=A0 bool set)
> =C2=A0{
> -	struct rtl_priv *rtlpriv =3D rtl_priv(hw);
> -	struct rtl_hal *rtlhal =3D rtl_hal(rtl_priv(hw));
> -
> -	if (rtlhal->hw_type =3D=3D HARDWARE_TYPE_RTL8192CU)
> -		schedule_work(&rtlpriv->works.update_beacon_work);
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

Looks like you could remove that entire method if it does nothing now,
it doesn't matter to mac80211 if you have it or not (since you don't use
AP_LINK_PS.)

Not sure it matters to you in the driver :)

johannes
