Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E927D5E112
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGCJdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 05:33:05 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:35768 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCJdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 05:33:05 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 05:33:02 EDT
Received: from bentobox.localnet (p4FCB2E24.dip0.t-ipconnect.de [79.203.46.36])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 21DEA20925;
        Wed,  3 Jul 2019 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562145809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62phGqDyDJAS+TaSJRkleRGAzjhbwnqgP7q9pIYGYFA=;
        b=ovpN8EsiOTfADIYvCockaoup8lG7l6k7sxqhyLjnHk6tYQ806EQogRIDoPMePMzPUKM/si
        jpTjsAGnRl5BnSvDrjNDj0SOOkqUIjqKK6vuJfE/R11qSQYKXQiU4yDPo6SU1l9aaVh3zk
        WYOwwbGABBLvU97HEShacOBN/F0Oe6o=
From:   Sven Eckelmann <sven@narfation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v3 0/3] mac80211/ath11k: HE mesh support
Date:   Wed, 03 Jul 2019 11:23:16 +0200
Message-ID: <1610842.TRhm9evnVP@bentobox>
In-Reply-To: <c025150aad17bbe62595c4969ea2f53f009419d3.camel@sipsolutions.net>
References: <20190612193510.29489-1-sven@narfation.org> <c025150aad17bbe62595c4969ea2f53f009419d3.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10083708.aL3fP4q7qc"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562145809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62phGqDyDJAS+TaSJRkleRGAzjhbwnqgP7q9pIYGYFA=;
        b=eZthFRatGx7oPmCIcoplZzKXIULz4TkGy70xXb8KXwIw/INaIHBaokEO6ByBjAtT2pK8rY
        Q+cJW4qjYqzjp1hrp6rBsSaVD8ayEpbm7FZvE3NhRM56654qiRUCsbXFkQsZbtthZCdcOg
        DZoSuuJFzY6iHT9F7n6kxKkT2sthh7s=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1562145809; a=rsa-sha256;
        cv=none;
        b=rrZxW4DbyVw4L05YltqsbuTJHnW+wLtFV077xGaITMFtI+z83Rm4XgEcceStSdIqbF6VYf
        JaUUxuXr+BQ/+zEFFR0oWaYeVEVTvZ+HMSy3imLCqsfErDQ6zZPxrfKseqbRmz/0KscRg1
        Ahj6seZ2440IJkJBbeD2OC5u1iF5P0s=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart10083708.aL3fP4q7qc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Thanks for clarifying your statement regarding ie_len. I think I should have 
been able to guess what you meant but for some reason my brain wasn't able to 
understand the phrase at that time.

On Friday, 14 June 2019 16:10:46 CEST Johannes Berg wrote:
> Two comments:
> 
> 1) It seems to me that patches 1/2 really should be in opposite order,
>    since you can't really claim HE mesh support in hwsim when you don't
>    have it in mac80211?
>    Or maybe I misunderstand?

I personally didn't have an opinion regarding the patch order. It was just the 
order how I committed the stuff. And it was just committed in this order 
because I could easier amend changes to mac80211.

But yes, (in retrospective) it is a lot better to have first the mac80211 
change and then the driver changes for meshpoint.

> 2) This series breaks the wpas_mesh_max_peering wpa_supplicant/hwsim
>    test, and I'm not sure why. Perhaps some length calculations are bad?

I just went through all tests and saw following failed ones before the 
patches:

   failed tests: tnc_peap_soh tnc_peap_soh_errors tnc_ttls tnc_ttls_fragmentation tnc_fast ap_ft_ptk_rekey p2p_go_move_reg_change p2ps_connect_adv_go_persistent p2ps_channel_both_connected_different ap_wps_conf_5ghz ap_wps_upnp_http_proto wpas_mesh_gate_forwarding olbc proxyarp_open_ebtables p2p_device_persistent_group2 dpp_ap_config_p521_p521 wnm_bss_tm_reject

and following after the patches:

   failed tests: tnc_peap_soh tnc_peap_soh_errors tnc_ttls tnc_ttls_fragmentation tnc_fast ap_ft_ptk_rekey ap_acs_vht discovery_group_client p2p_go_move_reg_change p2ps_stale_group_removal2 ap_wps_conf_5ghz ap_wps_upnp_http_proto radius_acct_interim_unreachable mesh_secure_ocv_mix_legacy mesh_secure_ocv_mix_ht wpas_mesh_max_peering wpas_mesh_open_ht40 wpas_mesh_gate_forwarding rrm_neighbor_rep_oom rrm_beacon_req_passive_scan_vht ap_vht160b ap_vht160_no_dfs_112_minus proxyarp_open_ebtables

So as you can see, even more stuff failed which I haven't touched. And other 
stuff which I haven't touched now work. The interesting ones were:

* mesh_secure_ocv_mix_legacy
* mesh_secure_ocv_mix_ht
* wpas_mesh_open_ht40
* wpas_mesh_max_peering

The last one (mentioned by you) is interesting - because I can see the 
accepting additional peers == No for the beacons in the dump. But it is not 
recognized as such by the script. With new tshark:

    ~/tmp/wireshark/build/run/tshark -r /tmp/hwsim-test-logs/latest/wpas_mesh_max_peering.hwsim0.pcapng  -T fields -e wlan.sa -e wlan.mesh.config.cap 'wlan.fc.type_subtype == 8' 
    02:00:00:00:01:00       0x00000009
    02:00:00:00:00:00       0x00000009
    02:00:00:00:01:00       0x00000009
    02:00:00:00:02:00       0x00000009
    02:00:00:00:00:00       0x00000008
    02:00:00:00:01:00       0x00000009
    02:00:00:00:02:00       0x00000009
    02:00:00:00:00:00       0x00000008

With wireshark 3.0.0:

    tshark -r /tmp/hwsim-test-logs/latest/wpas_mesh_max_peering.hwsim0.pcapng  -T fields -e wlan.sa -e wlan.mesh.config.cap 'wlan.fc.type_subtype == 8' 
    02:00:00:00:01:00       0x00000001
    02:00:00:00:00:00       0x00000001
    02:00:00:00:01:00       0x00000001
    02:00:00:00:00:00       0x00000001
    02:00:00:00:02:00       0x00000001
    02:00:00:00:01:00       0x00000001
    02:00:00:00:02:00       0x00000001
    02:00:00:00:00:00       0x00000001

So I had to change the wireshark version (see below) which is used by hostapd.
(just to document for me what I have forced it to a different version)

    diff --git a/tests/hwsim/tshark.py b/tests/hwsim/tshark.py
    index 019df781a760c657b8854acfcee94dc83e30575f..ecf83a7a97dde0e52b54e994d2dd4d46bddaa9df 100644
    --- a/tests/hwsim/tshark.py
    +++ b/tests/hwsim/tshark.py
    @@ -28,7 +28,7 @@ def _run_tshark(filename, filter, display=None, wait=True):
             time.sleep(0.1)
     
         try:
    -        arg = ["tshark", "-r", filename,
    +        arg = ["/home/sven/tmp/wireshark/build/run/tshark", "-r", filename,
                    _tshark_filter_arg, filter]
             if display:
                 arg.append('-Tfields')
    @@ -102,7 +102,7 @@ def run_tshark(filename, filter, display=None, wait=True):
                                wait)
     
     def run_tshark_json(filename, filter):
    -    arg = ["tshark", "-r", filename,
    +    arg = ["/home/sven/tmp/wireshark/build/run/tshark", "-r", filename,
                _tshark_filter_arg, filter]
         arg.append('-Tjson')
         arg.append('-x')
    
The first three things looks like wpa_supplicant problems. Seems to be 
caused by the way HE forces VHT to be enabled and now the tests fail 
which try to disable VHT. There was already a patch [0] for that but it
wasn't considered a good solution.

But beside these three things there are various other problems in 
wpa_supplicant regarding HE with pending patches. So I've used 
wpa_supplicant 91b6eba7732354ed3dfe0aa9715dc4c0746e3336 with two 
additional patches [1,2] and increased the VM memory to 1024 MB. Also 
wireshark (tshark to be more precise) had to be updated to 
v3.1.0rc0-1192-gf64990438c

Kind regards,
	Sven

[0] https://patchwork.ozlabs.org/patch/1125305/
[1] https://patchwork.ozlabs.org/patch/1125314/
[2] https://patchwork.ozlabs.org/patch/1125322/
--nextPart10083708.aL3fP4q7qc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0cdAQACgkQXYcKB8Em
e0Yd2g//XCDqFFeP+1p+O+4vzOTZMcRyk18NrXsgVZtjjYJx02Kve2kpYr+jL8/L
PET4mGEy2WtfDlzOHc5gp1Go+GEGMMKAzqMsNX1N0f0gQpdid5ULcpWA4qN3gMKA
whdvWE5Aq6ArdT8O1tRUtYseM2GMDud8e2OnUVDLSV1ooKAj+NMSEU0U0VCBnPx8
bUAHkZI+oLWloXTGA3YAbZYhbR+lan7F7VQek26c9bMuxNhea+unjjJfsEmdEh26
JRsLO/wL5T+W9LgiHbfh1JmFbPnt0vgKEfYt+9WqRHoKg1WGDykapx12jO9tLP4S
/VFikiy+6AjVriFn4Eyawrgll35njKVN7zS60MvtKu3HqqNT0nQeeH7HAOfqZD7/
aa8Pl9iw4IQmPL1ygyLL8tbHy8oeYNEU/oLmOVhe2iIHGm9W+o2YYRP6NyAAriIh
5zh0hi01eDWMGVaK7yLbU1UeEV4FZdTDdbMCn+fb88E2m1mi1sQC30am4hE+Hr70
N2chDD4KTl6fD7jgZnrFZUY4ZH73jbTnuZ5jfcoLWykTDbMKRFhOZ1ngnVij8vBG
Iz0XF7zZ0J1zvf/WTSC4XZtHovLQrAka05nf4+bd5S1vRJrydjX76z6hNkEVNV/t
s0QGP+8uezhbIArNSmrj9wYc8GxnYsw44zK0D/r1OwjoXhtw+uU=
=rLd8
-----END PGP SIGNATURE-----

--nextPart10083708.aL3fP4q7qc--



