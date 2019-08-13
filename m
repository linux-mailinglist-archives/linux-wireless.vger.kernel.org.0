Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72E8B67E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2019 13:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfHMLU4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Aug 2019 07:20:56 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:42514 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfHMLU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Aug 2019 07:20:56 -0400
Received: from bentobox.localnet (p200300C59716A6EC000000000000051D.dip0.t-ipconnect.de [IPv6:2003:c5:9716:a6ec::51d])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 96AFE20077;
        Tue, 13 Aug 2019 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1565695253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i3ipuVtrTVa15OtAWNudlVUiSo0reMpTg6/A+6OtF/g=;
        b=0+JpVxclFHjgXfHmiM8mfBq+zKloq7OXNJkC2pdsRmadJfvGBNO6zePNQAuLRIlyiZeBwS
        x+jPn2FhJQwrzNh51yojpA7c/k6spR8usIEbGgGTfoldbo4vxns63ueojM8MtrWdRsld4E
        DN/2hVCDShVxKXPcEMyq3eW4bzPi7rE=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jouni Malinen <j@w1.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] mac80211_hwsim: Register support for HE meshpoint
Date:   Tue, 13 Aug 2019 13:20:47 +0200
Message-ID: <3127506.552nsDcnha@bentobox>
In-Reply-To: <20190813105549.GA26160@w1.fi>
References: <20190813063657.7544-1-sven@narfation.org> <20190813105549.GA26160@w1.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2189091.y8c3oUoucd"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1565695253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i3ipuVtrTVa15OtAWNudlVUiSo0reMpTg6/A+6OtF/g=;
        b=Df2wxdpWyeQQ4PSA5C4HVFFjfcNM73nf1eqIT9gvQLDx++5RvHhV+SiZgy654HYXRkOY6t
        HLMbd1CYa5r1Hf47sJ78SAsOzrCpZT41M25BA803HLlpwya/pFxF+GSW3+cSr3mAYP70zo
        GMgXKfXqyOH3X9D4wH9ejjcM8PYbFZk=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1565695253; a=rsa-sha256;
        cv=none;
        b=jTh6KxkThdk4XhQmDpSlGSNLXLY5xpcmArF7KhMAQ3XeFX0lSKYs9MlFyF4xQAj/wjfS7R
        2DNJPXzuQFWPulnFuuEndAaveoqadoITP6vguPj2SmQXV9EcOTxKUr2cC7NVcRuKt1hYle
        ZfEN5QQRz9/k2GUX7KoGgN6pFNwDg/o=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2189091.y8c3oUoucd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Tuesday, 13 August 2019 12:55:49 CEST Jouni Malinen wrote:
[...]
> > [1] https://patchwork.ozlabs.org/patch/1131273/
> > [2] https://patchwork.ozlabs.org/patch/1116968/
> > [3] https://lore.kernel.org/r/2152977.f3ncjnVLFo@bentobox
>
> And with the exact same snapshot of hostap.git.
> 
> Without [1] applied, this mac80211_hwsim patch to enable HE meshpoint
> results in the following test cases failing:
> 
> mesh_secure_ocv_mix_legacy
> wpas_mesh_open_ht40
> wpas_mesh_max_peering
> mesh_secure_ocv_mix_ht
> 
> [1] fixes wpas_mesh_max_peering
> 
> This leaves following three test cases failing ("Test exception:
> Couldn't join mesh"):
> 
> mesh_secure_ocv_mix_legacy
> wpas_mesh_open_ht40
> mesh_secure_ocv_mix_ht
> 
> Am I missing a patch somewhere that would be needed to make those pass?

No, these also failed for me without the mac80211_hwsim patch [3] in a full 
test run. And thus not analyzed further by me.

Interestingly, they don't fail (without the hwsim patch) when running them
without the full test suite.

[...]
> So is that missing of vht_enabled=1 from some configurations the problem
> here and if so, would you be able to point me to a hostap.git patch that
> addresses this?

No, there is no hostap.git patch here. There was one in the past in 
patchwork [4] but there were concerns by John. So if you reapply the patch 
then you will see that it doesn't fail anymore.

    diff --git a/src/drivers/driver_nl80211.c b/src/drivers/driver_nl80211.c
    index d71511cb5..b54900bc4 100644
    --- a/src/drivers/driver_nl80211.c
    +++ b/src/drivers/driver_nl80211.c
    @@ -4360,7 +4360,7 @@ static int nl80211_put_freq_params(struct nl_msg *msg,
     	is_24ghz = hw_mode == HOSTAPD_MODE_IEEE80211G ||
     		hw_mode == HOSTAPD_MODE_IEEE80211B;
     
    -	if (freq->vht_enabled || (freq->he_enabled && !is_24ghz)) {
    +	if (freq->vht_enabled) {
     		enum nl80211_chan_width cw;
     
     		wpa_printf(MSG_DEBUG, "  * bandwidth=%d", freq->bandwidth);


So as a compromise, I can can propose a patch which tries to replicate this 
2.4GHz specific behavior from nl80211_put_freq_params also in 
ibss_mesh_setup_freq

Btw. thanks for pointing me towards specific test cases.

Kind regards,
	Sven

[4] https://patchwork.ozlabs.org/patch/1125305/

--nextPart2189091.y8c3oUoucd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1SnQ8ACgkQXYcKB8Em
e0agYQ/+K7yOYRoifjBo3ktXcoiyoM3cEw9wlvesVES+mVjYdhCE5iHpnLp0S7jp
2hCM28ZulL+pOl1qVtjXSPL6xkc7U6WCDuB0eG/KhmbqjGBYn/9CBF25pvvmomcY
mGn3f4GKfd5dRmKqxLXKalqjRu13VAWGXsSPWQUji9RJ6e7Y9VRIra4SWGjt717e
PMM9xA3GMzz/83ouHUssIfa+7yi4yxFQY+43yWTWTUEcNoPl7nyTbFF3170FlQiu
i/XWDQxEYqlBd8oVevt35RXpJw8E6+qGe1ke80J4GOj7zLLAZSnna9E2hyAq6kVL
m8Dbq4UguWvZsnc1aXwFJnFIozRiS5x7a+ETRgBF8UXEsbgeLTQ+of4mfGquPn8h
3kTQyi7hzapThXHmMHF6OsxBoK96Mow6iRIfNAesnKk+Zzec4/+hwmKOphSaIlTl
yzDQLiAwrHRGLr9aXD5GoKmcIYk80VOw/E5u5B7K1mVMmHTp5c5xK0m7EXBouHTL
z/ExiEn5WvioxG6l8y9TwT8Ff4/mp7lP2YKvvKiM3Hd+iv2tqRCpbkrEATJ5aCrv
iHpzIjq7gNmMLgm3jQSJwHylo9bADOhoYzXd8ZGJQ8vQrUY/YHnJuT7q83icjKjH
uiDDAsOhEXE5+gkUzNGRm2eztwBUTmJ2c3BVqSw5x4cXCQj3pic=
=gl+g
-----END PGP SIGNATURE-----

--nextPart2189091.y8c3oUoucd--



