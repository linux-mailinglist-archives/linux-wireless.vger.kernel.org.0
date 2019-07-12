Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFC669FF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfGLJg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 05:36:58 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:44612 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 05:36:58 -0400
Received: from bentobox.localnet (p5B34C47F.dip0.t-ipconnect.de [91.52.196.127])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 14D58201D4;
        Fri, 12 Jul 2019 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562924215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wheO9nb9WbFWTXNjfbiYs/cGQvHzl4hR33Th7Fu5DzA=;
        b=tILPGiCsDc+n22YSx40jg2nIMERcb5O4Tg6cHSTfXnvvbK0eG8g8I7+4/3c618ZQSCbQKQ
        Dl+X5tPdBh5qdOIdhclr/TD0k6s44ZB9B2C4sNDNKWXd0VSncei57d71QdFCDU2U3IRJO7
        Ek/DWqypE39OcXs+MQyaBKWwdrDjr7U=
From:   Sven Eckelmann <sven@narfation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        hostap@lists.infradead.org
Subject: Re: [PATCH v3 0/3] mac80211/ath11k: HE mesh support
Date:   Fri, 12 Jul 2019 11:36:37 +0200
Message-ID: <2019422.XptUlqRJNA@bentobox>
In-Reply-To: <06c7c1a2c8d0f955cb107475d17587c156fb19de.camel@sipsolutions.net>
References: <20190612193510.29489-1-sven@narfation.org> <1610842.TRhm9evnVP@bentobox> <06c7c1a2c8d0f955cb107475d17587c156fb19de.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2684766.PLg2N7XuUU"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562924215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wheO9nb9WbFWTXNjfbiYs/cGQvHzl4hR33Th7Fu5DzA=;
        b=zQzPZsN2lSBFLYbOshmcO+o6MhiAY2yqTk09PrcCEa2FMkgAhKIb6ZU7PEHOF5FEkwyGBU
        Z8jnGERJPb+8X1EHdKJJdymTjJ0LXFQsGz0qweXsS5ir34OBJJ9xVrl5Pii0axBdBO6n2x
        G/JmuLeYnsYS5+KcK/vx7ztqmGrULyw=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1562924215; a=rsa-sha256;
        cv=none;
        b=py3mshVX/VVrUVw6QPUO6V6BglIyUuSGpS0AvC/C3A9IhiuZ0sqvKlHSAGCk2ohzdP3teI
        a11T0cCtWnWjGK1rEMV788BLT/1r3ATnqZDuwpk/lVuYqYwUc4hvO6wtdF6JxSjyd5og56
        pswB9yKV9jNpBhukAZUMEbDwJt1KFuw=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2684766.PLg2N7XuUU
Content-Type: multipart/mixed; boundary="nextPart34744749.rJ6lG39BOJ"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart34744749.rJ6lG39BOJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 12 July 2019 09:58:50 CEST Johannes Berg wrote:
> On Wed, 2019-07-03 at 11:23 +0200, Sven Eckelmann wrote:
> > 
> >     ~/tmp/wireshark/build/run/tshark -r /tmp/hwsim-test-logs/latest/wpas_mesh_max_peering.hwsim0.pcapng  -T fields -e wlan.sa -e wlan.mesh.config.cap 'wlan.fc.type_subtype == 8' 
> >     02:00:00:00:01:00       0x00000009
[...]
> > With wireshark 3.0.0:
> > 
> >     tshark -r /tmp/hwsim-test-logs/latest/wpas_mesh_max_peering.hwsim0.pcapng  -T fields -e wlan.sa -e wlan.mesh.config.cap 'wlan.fc.type_subtype == 8' 
> >     02:00:00:00:01:00       0x00000001
[...]
> > So I had to change the wireshark version (see below) which is used by hostapd.
> > (just to document for me what I have forced it to a different version)
> 
> What. +hostap list.
> 
> This makes no sense, is that a tshark bug in one of the versions?

Yes (but more a bug in the ieee80211 dissector), see 
commit f3ef8575d462 ("ieee80211: fix wrong offset for mesh configuration 
capability bitmask") [1].

I've also attached the pcap in case there are still doubts about my statement.

As you can see, it will just fail to parse the mesh peering management element 
correctly. It should parse the last byte of the element payload but it falls 
back to parsing the first byte (path selection protocol) as capabilities. See 
9.4.2.98 "Mesh Configuration element" from 802.11-2016 for details.

There is already a workaround for that in the hostap testcases:

    if all_cap_one:
        # It looks like tshark parser was broken at some point for
        # wlan.mesh.config.cap which is now (tshark 2.6.3) pointing to incorrect
        # field (same as wlan.mesh.config.ps_protocol). This used to work with
        # tshark 2.2.6.
        #
        # For now, assume the capability field ends up being the last octet of
        # the frame.
        one = [0, 0, 0]
        zero = [0, 0, 0]
        addrs = [addr0, addr1, addr2]
        for idx in range(3):
            addr = addrs[idx]
            out = run_tshark_json(capfile, filt + " && wlan.sa == " + addr)
            pkts = json.loads(out)
            for pkt in pkts:
                frame = pkt["_source"]["layers"]["frame_raw"][0]
                cap = int(frame[-2:], 16)
                if cap & 0x01:
                    one[idx] += 1
                else:
                    zero[idx] += 1
        logger.info("one: " + str(one))
        logger.info("zero: " + str(zero))

But maybe you already spotted the problem - it requires that mesh 
configuration element is the last element. Which is not the case here - 
similar to 5GHz tests (where you have most likely a VHT cap/oper element 
after the meshconf_ie).

I hope that this makes more sense now.

Kind regards,
	Sven

[1] https://github.com/wireshark/wireshark/commit/f3ef8575d4620a62f1c4609bf14961c3e78993f3
--nextPart34744749.rJ6lG39BOJ
Content-Disposition: attachment; filename="wpas_mesh_max_peering.hwsim0.pcapng.gz"
Content-Transfer-Encoding: base64
Content-Type: application/x-pcapng; name="wpas_mesh_max_peering.hwsim0.pcapng.gz"

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
H+TWTnj8kKdrXkzJaNfU9/gPnwFgjIQtAAA=


--nextPart34744749.rJ6lG39BOJ--

--nextPart2684766.PLg2N7XuUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0oVKUACgkQXYcKB8Em
e0aBaA/9EtPZknG2/68kcob1fBMsQ5Bcm2MeH+DZQ4LGXwD17/rwe3NHyuap/gDV
YBX/BbU2lYrgXMNtVi1rSpN2qlmZKjJm0Q3s+ASFsC1jDommDbt1Y9AzpGYvFzIT
t1q4XvMWSW1aEAp4nttmwDsSEpzPETsBmZOyrcLBDKagmRQ84h7RJXied4UPAZll
AA1nJ16V7HcZnXgi2tTgTYjn9WdazG4scoL/NzZIeYNr2xCgWFbpqn4PzI6MTSvl
ofKozgk4P+RiuL/g2W8Sh13Tc12M9oFlEgKuoJt/1ztQebM6Ud2w7L4gYjWHlShv
RnWGXHSmzoG9bTDYwxSRWCBkk3OEDFmWafUIYRibrPbKII2pJhOY/lSKCQ3Qii3u
jxEHEPlA0RNXphP/MfSh+YVFA3TU5NAbMnXtwBTdfMjYwIvWClCe3vk2wCpsRvDN
/p0xFW88x6yvksZ3zpH3VKui9do5JzII5AOdcIVAezJNrOQeRFq54MnKME856rWh
XPGkRQbpM/u1OREXK5VTqOsucuxCPqf46J3n+zoAO28Obzf4E/OmWQhCG5T/1RsJ
/EGTjdSmyU3plHaXadKNxeiBzhHdN4SZJ3ByxE3QBwnHHdtbCeehXbohE64N+p04
xVI4E+v5CG/4216FY1wbdOMa7ZKci3hM/WFanTnFQFIdzcIw4ok=
=JQTt
-----END PGP SIGNATURE-----

--nextPart2684766.PLg2N7XuUU--



