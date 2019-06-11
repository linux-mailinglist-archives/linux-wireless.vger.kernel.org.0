Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0733D757
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406016AbfFKT6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 15:58:45 -0400
Received: from us-smtp-delivery-195.mimecast.com ([63.128.21.195]:29291 "EHLO
        us-smtp-delivery-195.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406025AbfFKT6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 15:58:44 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 15:58:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datto.com;
        s=mimecast20190208; t=1560283117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dfkb7eaLCP1We8E/2sqrWkSOUVTy/g24zothoWydZek=;
        b=ZXryiR2KdPJGb3kEtmb8SEN8lCBB4eRA6V9VZResmujcRvQ8FrNFVbzT+lLaQRyxsFbWp3
        qoKE9VZDPNrP4i7UcJ60E/hf+LQ6HGs9pl6p5cib4L6FaazEDp6RmHFBSeRkCF8kJINgCb
        VAyRDssh9E1TJIG1qAEbq/6y/Gr9fPQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-UT7IQZe7PRmBY4rd4IOuVA-1; Tue, 11 Jun 2019 15:52:28 -0400
X-MC-Unique: UT7IQZe7PRmBY4rd4IOuVA-1
Received: by mail-qk1-f199.google.com with SMTP id i4so11834491qkk.22
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2019 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datto-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=dfkb7eaLCP1We8E/2sqrWkSOUVTy/g24zothoWydZek=;
        b=DOxjX4MHUj/9PXeEyCCAhHNGF+yW25opBYS+w7yGh4ihrUk5RPDFiYcIvHRRTrNad0
         NCFJmT/4qES+R8d3E66NtzpgmjGSouBSLooPsdV9GoyQGoXI7gZDPxJAV0XA3VbuQucG
         ntwXoL0wMWegar6dsk2+oHujh6GMlnjpIaopMOJaVsICCpbMO+GhtNHiwjFl+4CS4qnz
         FJBg4GnpZDUedlAPSUK40wx5O0/7OGmL/bgoPEmockdhYryaTiNdd5a9zyHx+vSKLr9I
         TzSbKm0h/KnsRQ7MaUnhIVSj5m9C8pvSkfB2aZa/opAWO/GpzzEP8WmLbv4CQz7jfCYB
         mDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=dfkb7eaLCP1We8E/2sqrWkSOUVTy/g24zothoWydZek=;
        b=f38hPdjVQQt3GKtDl5rb+xgt+TQrkPRzgALo9tvM1vegDZO7G8QqKn7fkndP76VrKN
         se7H3VPC6YZSjEFk+SZ10ydbQz54ZWHXJXEqkguflDk7/+f88yWwoJw3/KoLEUC51Y+K
         KqaL/dP2uhTxmLbAoA1sMhud/ZjG440fTV0BWRRpmp5tOEzFUklQO6dfL4V/gC4IvxAf
         DRQldVR6vpmWAFsi7c3NTCht6FEvTfjJ1JRB7NfYU/SIJ6sPBfXpJdmllG1rRwM9NdVh
         PcbWjOVpSuZEWcQYo7pDUDlWHCxlqWAZFAQTNdelKBU2F397FAaW6fgqcqaUsRpzdTAh
         YBxg==
X-Gm-Message-State: APjAAAVYI8JF+jl6QzW3Qm3OrsEh1aEzcHqP4u5Q7gmFrRS8EQhhToyQ
        IXNX4DO8NB2lPDz4MDXnsSlVrcaniAFDvtFS09JiLZTJOzxekrRgeHNjZAnh9JCl1KxOxNIOiwO
        BL8OviAd6K02htIQx6G6wTEG68HM=
X-Received: by 2002:ad4:5386:: with SMTP id i6mr2004698qvv.237.1560282747992;
        Tue, 11 Jun 2019 12:52:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQxmnIKSOVhWqGeL2Nx1U7cVWc3ks+gpG9wcn1osdUT4GQo9GFncbHFTN3UfoXCIU0f1L5WQ==
X-Received: by 2002:ad4:5386:: with SMTP id i6mr2004684qvv.237.1560282747800;
        Tue, 11 Jun 2019 12:52:27 -0700 (PDT)
Received: from bentobox.localnet (p200300C5970379EE000000000000070D.dip0.t-ipconnect.de. [2003:c5:9703:79ee::70d])
        by smtp.gmail.com with ESMTPSA id q29sm7471109qkq.77.2019.06.11.12.52.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 12:52:26 -0700 (PDT)
From:   Sven Eckelmann <seckelmann@datto.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Bob Copeland <me@bobcopeland.com>
Subject: Re: [RFC PATCH v2 3/3] ath11k: register HE mesh capabilities
Date:   Tue, 11 Jun 2019 21:52:20 +0200
Message-ID: <1919330.hVZVHELXip@bentobox>
In-Reply-To: <20190611180247.19524-4-sven@narfation.org>
References: <20190611180247.19524-1-sven@narfation.org> <20190611180247.19524-4-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6218786.OGWznZaXkY"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart6218786.OGWznZaXkY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 11 June 2019 20:02:47 CEST Sven Eckelmann wrote:
[...]
> ---
> This doesn't work currently as expected. No HE rates are used between
> the two HE mesh peers:
[...]

There seems to be also an ordering problem. ath11k_peer_assoc_h_he is only 
called before ieee80211_he_cap_ie_to_sta_he_cap is called. So ath11k_bss_assoc 
will not have the information whether the remote has HE support or not.

Looks like I have adjust mesh_sta_info_init to get this somehow to 
ath11k_peer_assoc_h_he. Maybe through ath11k_sta_rc_update but this is not 
called by mesh_sta_info_init at the moment. Just because 
rate_control_rate_init is called and not rate_control_rate_update.

The easiest method seems to adjust the check at the end of mesh_sta_info_init 
to 

	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL) &&
	    !ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
		rate_control_rate_init(sta);
	} else {
		rate_control_rate_update(local, sband, sta, changed);
	}

and to create a IEEE80211_RC_SUPP_RATES_CHANGED change when the has_he state 
changes. And yes, I know that Bob Copeland added this because it would have 
crashed ath10k when rate_control_rate_init is not used [1]. The other 
suggestion would be:

	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
		rate_control_rate_init(sta);

   /* inform drivers about changes */
	rate_control_rate_update(local, sband, sta, changed);

Both will at least cause a call to ath11k_peer_assoc_prepare + 
ath11k_wmi_send_peer_assoc_cmd but unfortunately the ath11k firmware hangs 
afterwards.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=1d6741d86429a294f51f2773c751c8f7662e7ca2
--nextPart6218786.OGWznZaXkY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0ABnQACgkQXYcKB8Em
e0ZDTw//VlKtfZHuBBaQ9jy4c8svQ6EuOrANQe2WjL6YL7w24GFcLah7Azlmlu8n
E+KxhIdstajByPKIkS0i6ovW0GHBi+UpoP+dJ+Kt69sikzRVL+tkKRZOdSgm8XV8
g+/wErjwHUz5IQZ0rvyS5TPwcwZeo6zlEMqG384o8ip+AMqUBptWQKIdylTdvJqC
2UAWzuog24z96hgD3zRs5pzDypRZMfvTPgpsJzeKxnomTSJzDZk6orRjxdrxB3QR
1Jvj+cQ3tXrSs4l6Tp8HG01iKMg/4iPA0M8up/xlYWlOnKYoP/xhrJJUf1jpLcHo
Q2TKhGtHBG1TZEvNdiihYj8bFRCRrXLvcXLYODa0u4Hs2dMfSi30IEKb9zwY4zfE
ZjBWGIWcEvv+s/vsBNxZjiGXsyWbY5u++etea4OPx2Y3x/IrwzBRNSOQBqtLa7Ul
szRM+a4LdAJ+uIGXYs+9dM5OqGA0JR3SnwCxth3NRaYe9OExVAEZUNruL910lz+H
Rq7p+T/SRfSBWGRUaFo0iKPopJ1ICJ4bRFxRUnQuV3MZxpzpEcNPCzJ3MERTNGzt
+PD7ywI/1vWUKb9Upkel2lKp0g6/76BSROuwai1vMbE91E1WAIrBKMzhqqaGQyfC
xDstiRGa7SZSey20ElA7Dti6agub73tGfi5dRlVjtaR4oy1kG8w=
=pPAK
-----END PGP SIGNATURE-----

--nextPart6218786.OGWznZaXkY--



