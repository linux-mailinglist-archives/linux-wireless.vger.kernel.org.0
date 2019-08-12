Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295D08A283
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2019 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHLPlc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Aug 2019 11:41:32 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:50896 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHLPlc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Aug 2019 11:41:32 -0400
Received: from bentobox.localnet (p200300C5970F63006D7EACDDFF52BF52.dip0.t-ipconnect.de [IPv6:2003:c5:970f:6300:6d7e:acdd:ff52:bf52])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 9451920077;
        Mon, 12 Aug 2019 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1565624488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P01hGv2hAqpGZJQIBWTQgbganOKN4VBAqIW0tdLgY1g=;
        b=s6t9qMHSs+884OgC2eUpJ2RpZjXzETqioZbzg0gqMh7Dd6yuF2Kn+7UPkHfv6L2V34d2bJ
        ZWJkGnZLKa7o6e5WfhXAnmH9+O6CVbflZz+MU+QbQAfWP4g6y9F9MLBZWTm0pD2GAJSwAR
        W5wFYWvzGHJoz9xgTR8iwE5Flq2aHg0=
From:   Sven Eckelmann <sven@narfation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 2/2] mac80211_hwsim: Register support for HE meshpoint
Date:   Mon, 12 Aug 2019 17:41:18 +0200
Message-ID: <2152977.f3ncjnVLFo@bentobox>
In-Reply-To: <eaaff61b1e35c43ee64f728c97a02bfcd15c295a.camel@sipsolutions.net>
References: <20190724163359.3507-1-sven@narfation.org> <3082836.hUm4yBdaKs@sven-edge> <eaaff61b1e35c43ee64f728c97a02bfcd15c295a.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1601601.eSNR8Z8plV"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1565624488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P01hGv2hAqpGZJQIBWTQgbganOKN4VBAqIW0tdLgY1g=;
        b=aor/ZkmrM6gpb1DUhG2ooSJV9o7FT4sZ5qHazKUvQcysWIkjen6KOOqrM8J7FqLOZL/h0k
        zsWdO7RfqeL286f1ZlMZrMcDeECslsVfpU29JNxqxTbQ1TqbzUa6tDXrWAT6SK0YqKfK4i
        yd3JT6BpnD3MMPVe2kPIXQdc0Y1EoHE=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1565624488; a=rsa-sha256;
        cv=none;
        b=2Bu8MnJNyGow4W3knToCjfIBLz/SQaCGTQcuCREKBdOeoPvHrZdecWY3J5Z6fQTM3zCp7H
        SiWeeG3LA+OaLQdmevnRoyDi5WLJI6NVadi79goqeuFO3LtEYuonnoyTWg/bR3+Socl2Fj
        uhXzAbm4NywPlCZZvogPfd15KJsKslU=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1601601.eSNR8Z8plV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 26 July 2019 15:32:50 CEST Johannes Berg wrote:
[...]
> Ok, dunno. But I don't really want to break everything in the hwsim
> tests, even if the kernel patch may be correct ... so I guess I'll wait
> until you resubmit after some fixes go into wpa_s?

Ok, will try to do this. Seems like Jouni merged parts of the patches but 
there are still things pending.

Btw. with the patches, I see following things broken in the test suite (single 
run):

failed tests: ibss_5ghz fst_sta_tear_down_session_bad_fsts_id tnc_peap_soh 
tnc_peap_soh_errors tnc_ttls tnc_ttls_fragmentation tnc_fast 
p2p_set_discoverability ap_ft_vlan_disconnected ap_ft_eap_vlan_multi 
ap_ft_ptk_rekey ap_acs_exclude_dfs discovery_while_go_p2p_dev 
go_neg_forced_freq_diff_than_bss_freq p2p_go_move_reg_change 
p2ps_stale_group_removal2 p2ps_channel_active_go_and_station_different_mcc 
radius_acct_interim_unreachable mesh_secure_ocv_mix_legacy 
mesh_secure_ocv_mix_ht wpas_mesh_open_ht40 wpas_mesh_gate_forwarding olbc_5ghz 
ap_ht40_csa ap_ht40_csa3 ap_ht_op_class_124 wpas_ap_dfs proxyarp_open_ebtables 
dpp_test_vector_p_521

Without the patches, I see following (single run):

failed tests: concurrent_grpform_while_connecting2 
fst_sta_remove_session_established fst_ap_config_oom tnc_peap_soh 
tnc_peap_soh_errors tnc_ttls tnc_ttls_fragmentation tnc_fast ap_ft_ptk_rekey 
ap_acs_exclude_dfs autogo_many discovery_group_client discovery_listen_find 
discovery_while_go p2p_go_move_reg_change p2ps_stale_group_removal2 grpform3_c 
mesh_secure_ocv_mix_legacy mesh_secure_ocv_mix_ht 
wpas_mesh_secure_sae_group_mismatch wpas_mesh_open_ht40 wpas_mesh_open_vht40 
wpas_mesh_open_vht20 mesh_open_vht_160 wpas_mesh_gate_forwarding scan 
scan_setband ap_vht160 ap_vht80_pwr_constraint proxyarp_open_ebtables

So the diff is (- == before HE patch, + == after HE patch):

     ap_acs_exclude_dfs
    +ap_ft_eap_vlan_multi
     ap_ft_ptk_rekey
    -ap_vht160
    -ap_vht80_pwr_constraint
    -autogo_many
    -concurrent_grpform_while_connecting2
    -discovery_group_client
    -discovery_listen_find
    -discovery_while_go
    -fst_ap_config_oom
    -fst_sta_remove_session_established
    -grpform3_c
    -mesh_open_vht_160
    +ap_ft_vlan_disconnected
    +ap_ht40_csa
    +ap_ht40_csa3
    +ap_ht_op_class_124
    +discovery_while_go_p2p_dev
    +dpp_test_vector_p_521
    +fst_sta_tear_down_session_bad_fsts_id
    +go_neg_forced_freq_diff_than_bss_freq
    +ibss_5ghz
     mesh_secure_ocv_mix_ht
     mesh_secure_ocv_mix_legacy
    +olbc_5ghz
     p2p_go_move_reg_change
    +p2ps_channel_active_go_and_station_different_mcc
    +p2p_set_discoverability
     p2ps_stale_group_removal2
     proxyarp_open_ebtables
    -scan
    -scan_setband
    +radius_acct_interim_unreachable
     tnc_fast
     tnc_peap_soh
     tnc_peap_soh_errors
     tnc_ttls
     tnc_ttls_fragmentation
    +wpas_ap_dfs
     wpas_mesh_gate_forwarding
     wpas_mesh_open_ht40
    -wpas_mesh_open_vht20
    -wpas_mesh_open_vht40
    -wpas_mesh_secure_sae_group_mismatch

None of the "+" marked tests are reproducible (they test suite just randomly 
fails as it looks like in the moment).

Hostapd version was 05822609d105 ("HE: MCS size is always a minimum of 4 
bytes") with two pending patches [1,2]. Either John will resend the first 
patch [1] or (when he is busy) I will do it in the next days.

Kind regards,
	Sven

[1] https://patchwork.ozlabs.org/patch/1116968/
[2] https://patchwork.ozlabs.org/patch/1131273/
--nextPart1601601.eSNR8Z8plV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1RiJ4ACgkQXYcKB8Em
e0b1bhAAlXH1er3Ip6PIsMuZ74TWKHj+b739/oZQxTL9Z6tCbzQ7v6EHQvH4QvbE
VnczrfhN+W2ppI3tOE3M1p3RjR5NUwy6SO3qPKqkv5xazesGJ2NcY3kK1/3plTjT
GlS6IVn2FC9RBp0fFoq+6MkUBqXbEDeIiXg+9fbzcMUiXEKGKp7ZYuJMCAHYYFI4
4rxWE8ABfb6dQpkbHPDECeMDfPWFdIsyiQYHoAyxI0m4V3NnEAiRQPDpyanVnQvP
ht6QyLWWHSL+ByZyoPtvUBWdmRgUP4p7oKSar3Y2c5/S2jLQGcTcMQBdqDJJwxwG
03djuAyWcsGiQNHCpzFPlYGcjqGE/FOqiUC9mKxATIPkiapMRDW3hOvGY2Z2P9A8
K7IYKsrkyXzxFa+tbGWVoFMosx+VUosVa1uV2UiTpOsxClo67UOnNuhQaNdDbtSa
PaV3iTZCjScFXO8a8A6vgXhsDHgSWNsU2F+MWpeJv/ohk3IJGHJCO6phfy0q0MHu
7n5xn6lqBFDr4/0HvcqXRoi/pUx0xpRaUUoFNVNpsyh5CqLQ5YLM2YZsuINrMk7S
ihPkNzBlszBFv002PSJsmdzciMtt+sUYZ/OAFmhs+crl9bKgqA7ayM4uJdya4XiL
wZOiI/EIUxGgKF9iDKpHpxUwfGa/uDMz3vtSYdwybjPrQ1sGkho=
=gv9i
-----END PGP SIGNATURE-----

--nextPart1601601.eSNR8Z8plV--



