Return-Path: <linux-wireless+bounces-36761-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AFtONfrDmqwDAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36761-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 13:26:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 628715A3FD5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 13:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0FA33088346
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39F3C0A18;
	Thu, 21 May 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jLQ/k4HZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76237F73D
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362659; cv=none; b=fniC+q+cnHMapiN+alYNok8nV0uQ9vRbDUSrdXw7V6k3gX7atyUrKmleP2FfbxF8801vHC2APJ+9ez4FqCBTgGmBeGQvguBGAcgL4j50cd5N7KPSB9XXRoXxDX5pzDuwNIXVnNnbUKOJrBfTc5rBFHjkT9nkUsaIH/A1aqQYBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362659; c=relaxed/simple;
	bh=grka2Hej+2UnThRpDa9TcD+vGGuqZ85VhiLwMk8SvwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=T34O9zV7In5nBpqOBpPIgetw2iwlg1UfwrBHAPxyBse5cm4JmCDtTQ+R4NuoWShGic8vOO2JN1lN+wdsytfV+pK3f+hZ5925S17avoWRHXCdWLD9599gsP5V59vEB7Bojg0g87S1/Ykp6gHOqEC6suGL+hKB+cYZD67v25g/ZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jLQ/k4HZ; arc=none smtp.client-ip=98.137.69.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779362657; bh=VKH1T9LwL69OF6A+lPnkkmK3V3zvqz8owpPJtLn+mUU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=jLQ/k4HZ4rIcGYzB4g1V7cAuGz9eqOymYR9oEgDrjpgbPAnVPqt5I5AhtOd6v0xQSwf3QGgTbeCskjR8FI8JM4O326T4QvPStShF0cjTIfEL/VKEro5DtvtklhWdSJyxygS2YI6mXJC+GVRTmyDCKmqn4ps1R4lju+WGVlx9LuAoFJDQ/IQ3KK0eRXuJVw+Eymq+HQUBMJlsm61+JkvoFs16ZQUKvL3tX4sU4PidOVmzDWLU8iqbTvdUal5UM4gQ2Hw0nhI+iOKJSHq/NpsVwyN9dw1xrMl4lRk5ywWtQ4O3GwM0vIA3K97ByFcsBglsLD+LjomSaTXNYiNoATW/QA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779362657; bh=IR883WeSAfSjLWlsViVFtQD8QcgeUZKdiUytrg+7MPP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YRL3e6FIYg9GRj9c8sYCQVYukdGmJW7WFpnf07zqrA4wUejD55GBa1FPx9Xy6270YqTqTxQMDCsXUTwOVLQPaEMetUdI2FYbImE8gqNy3QBYW5aMa48ufcJ5MCV72Q74uWFpv/uWauVmjNjVep/Uxwtxv/3JBxvj7EW925mmJjKElqAZjy6UIyjQ+JxZRgtWPNBzz4tLTrAwkRRiKuh7UutiF3IY7cvbBo7Poc+Ty+3YiwORIWz8HyqB1v13S+VjKqjymvDo4PWAPSCEHguX1YCC3GUuhwepl++uRtmCw/xN93wQqNJ/KsPRTaqzZTm2PyhJL4bTzK+KznDEh4ZULg==
X-YMail-OSG: 486h_l8VM1leLh6a921ZnD9VY5nt1qHK5nrhN3s0q7RIdHFCrh7py7jqWc4S4KQ
 6ggn5KybRk3s_ZU2IUrlb2Flcz_6.jKvDumA8z3SWUJ5i.kbYI8bSQsDkh.3dRTiUJui_rXFjXIb
 4GBsvfuavHP62eCxOrWiZa.Ftuo_KCUzl6hYkPSUuzzVDL8w.JVsCHtHff5m4KkQww4SeDEh8IOO
 kCuXuTYLyarNGtY.g.sZfWfWYwBS6Xyy3nLiLBGy5AKANsIySl3NKaSrDdjxbFetbm_1YGdx2eAo
 TkFIX9KNfR8BSQfJtfNzQ45hvUO1CyjprbaUCjxQkrQ6T3zkWdwwhDYwsPMjHU8xLZuvbB8_gmdX
 xOQukT0UCCizxmNKsdyCo9yeFphUOUlfKA67S3zwiWS8uSm0bfelOqNndwETFPw0obfGAN3EqwYb
 N_fTyyvnfBPSh4BrNO1Bd0olUXWFFpg7xZbJwrlL4raRXnX_owBGcjzczuNniwcL0lL48TyWPUG2
 BIXEzHYkXi7IsbBFG1GV83sGD3l7P88AVSSaH3k5nQ94u0Kk79kiNqG.r_4hI0n9_AduufT3vzRL
 ZxSdTIlL0e1rfr2r5mZI4XTjlvqNM5PhI4Du9eAB6zmhpYBMBTYeRYk0P5oWRBt5R6BTKg5Rok4n
 n3MtEuUhgQzI2xRdCSe0k1kcVyLvfX6jnhRoc2WHN5Ko8_R8NCKUat8gxocVhJFRoh9P0KX0g90J
 rplZLDFhBNGH_FwGfcuuPYvqE1E2wNaqctxblqMJDJ..XHY6ykQ9aaO16vRDrM1Gkr8ImG9BvANp
 Y0R02SB6GafViN73tHKY9KQYGWqfPcwA7cpBmoJvjKaaAQT9PrRh18DvYHY2_g7SkkAlPJSUcGp7
 yzj5eV.X_2vHl7zC1lFJX.vZcIl1SN_LnGPj85fRAOwdQUZH3GeUJYHrb9t3o2YXXygHarfdP8EQ
 dKDDBTZo0ZpkX06jbJvJSMNpS63_f4Zv5WpzxhsO489K.9kbkwkWwcTai0RSZ2WZveOr9NJWwjzc
 Ac1_zkT3huu3n0i3RlKBsSbVvOD8ACLFO0oIst1ndkv0dkT1PXwL3mD49xOgojayr3e3M6qkOR5D
 1g59tmFByI0_JknDVuPBowYs8zSNTsAiqgv8fYTIblps.7nSyjdE.u0HYtzqf20W3DLxwPkhYJxX
 ln3GkDANcGMhOyDvrpQYDEqpa0VVZyMBwY_3ol4HFHWNWfEpTRxF.rfhKJA0i8FzVBfd.fk2j3ns
 V1nxD6cJHyeyAZ.4kwMXlCLR2M4sQm1CaxMUrjp7sUfUURALLfnnurV2SxEquL31HUYzwHItkZRe
 3Uim1h7kDAufrZKDhwu3yE_cbAwKJoncwnq9IxB.2UpPq70dtxivNVmjEQUopZmYejCs2737DXzm
 _1GZsS5mxNyC0ZbIsiHWBA9l0DXXYz6gvzqc_aq.194bj4JcbvPEILle0kmSZOOfAxORZty35xbQ
 pIRc05MWK3rFGTUAb_4vWXm3E7_zp2T0aBclFWCVOzm4mGUPVBF8y6UXuaZS_AVjMh2zDsyYKCQs
 yAmtQI.ZQnrfgQmBa74h8ndlPfcYK0Uss3IJPZBDC0rsagJt8FIwUu_61KNxPFk5k6_0SOfb0XBs
 8VEeWy0OzfHvH1oaUDf.ELKSLLkITczHR6XDQrkou2WfYgC2LE_4FIKoFT8R4a2dC5lgvaIuqSQ0
 rC_k4bqhojRbIJ2nt6fhZkZQ35EAH69qjshHxeXQIwZOJ9VeI1Fh1OhyNFB6NDBlOO_i2.y6p.Ob
 gNZKSA5jCsGlGQkMVUpPGtwSW.Llz9gjHoKmxV8vK7j4V0h7xfVgzO6WYd8sqQpDbJY2pLJdrtiG
 7CtxJwuFFWDnBTMact6Xohf6_45iP8bavijKz.WMbEjTiNHRbvuW8sk7MbBWT_xrawFK9FqfUpeA
 gx_dr1bQMd9OIlUStsLEhaR9PwzSxHYlORtB2SDGoJ5FDI_T2IC.dh4q7bDZsV1fiWvj2HqUDLJU
 CASoRVqkiWuClS7xDBe4CE3fP4bTJqN.sVibfBjBmJNhx8HZQ2BgG0VBAu8CW67qmW3Yk1gAj1Fn
 lnkSvXxUyCPs4.00lFBJHUAplDZzRaCIfwcpvt7EeKjNoDRT5KQuhbwHW0v8mg778dih6VAI4qeO
 ssZ8i_FO1l701fBRqddgVdUJpLZT7ps8oH3Uz6fb7x258HF4ekNnRUZj0MlH9JoCR8pfdELeBm96
 _LGcIowk7xAR.0xHPQsbH8dtU.5tKJKAR_crMJGLsr0ttZPD1sV3WSVSjDA4GSUjWNwwHy9GbPHY
 Ct1DcXso5azC0ojDvGi.IdguHkKRhvZGiIgB.oVGt.Ehf
X-Sonic-MF: <mnew_iraq@yahoo.com>
X-Sonic-ID: 96705cf2-8b44-4784-857e-8c058567af12
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Thu, 21 May 2026 11:24:17 +0000
Received: by hermes--production-ir2-89844b765-j4kkl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d90c43c097eb46b10d493f0b503d2068;
          Thu, 21 May 2026 10:15:09 +0000 (UTC)
From: Mohammed Abdullah Ali Al-Obaidi <mnew_iraq@yahoo.com>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	Mohammed Abdullah Ali Al-Obaidi <mnew_iraq@yahoo.com>
Subject: [PATCH v2] wireless-regdb: add regulatory rules for Iraq (IQ)
Date: Thu, 21 May 2026 13:15:01 +0300
Message-ID: <20260521101501.1841-1-mnew_iraq@yahoo.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260521101501.1841-1-mnew_iraq.ref@yahoo.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36761-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[yahoo.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnew_iraq@yahoo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_WP_URI(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cmc.iq:url]
X-Rspamd-Queue-Id: 628715A3FD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regulatory entry for Iraq (ISO 3166-1 alpha-2: IQ).

Iraq is currently absent from the regulatory database. Devices set
to country=IQ fall back to the world domain (00), which leaves most
of the 5 GHz spectrum marked "no IR" and severely restricts even
2.4 GHz operation. The Iraqi Communications and Media Commission
(CMC) has now published an explicit, numerical national regulation
that fills this gap.

Source document
---------------

  Title : Regulation on short-range radio communication devices
          (SRD) and devices using ultra-broadband (UWB) technology
  Issuer: Republic of Iraq, Communications and Media Commission
          (CMC), Telecommunications Regulatory Department,
          International Relations Section
  Decree: Council of Commissioners decision No. 122/q-2025
  In force from: 2025-09-22
  Edition: First edition, 2025; 26 pages
  URL   : https://cmc.iq/wp-content/uploads/2025/09/Regulation-on-short-range-radio-communication-devices-SRD-and-devices-using-ultra-broadband-UWB-technology.pdf

The values below are taken directly from Article 4-1-13 ("Wireless
Access Systems / WAS") of that regulation, which is the table
governing Wi-Fi (Annex A of the regulation defines Wi-Fi as
"802.11 Local Area Networking in 2.4 and 5 GHz ISM bands"). 

Bands and limits, as stated in Article 4-1-13:

  2400-2483.5 MHz  : 100  mW EIRP, indoor and outdoor, LBT/DAA
                     (EN 300 328, ERC/REC 70-03)
  5150-5250 MHz    : 200  mW EIRP, indoor
                     (EN 301 893, ITU-R Res. 229 Rev. WRC-19)
  5250-5350 MHz    : 200  mW EIRP, indoor
                     (EN 301 893) 
  5470-5725 MHz    : 1000 mW EIRP, indoor, DFS + TPC
                     (EN 301 893)
  5725-5875 MHz    : 2000 mW EIRP (10 MHz ch) / 4000 mW (20 MHz ch),
                     indoor and outdoor
                     (EN 302 502)
  5945-6425 MHz    : 200  mW EIRP, indoor
                     (EN 303 687, ECC Report 75)
  57-66 GHz        : 10   W  EIRP, indoor, LBT/DAA
                     (EN 302 567)

Notes on the encoding chosen below
----------------------------------

* TPC handling for 5470-5725 MHz: The regulation explicitly requires 
  both DFS and TPC. Because Linux/wireless-regdb does not natively 
  enforce TPC limits, the rule is encoded with the standard DFS flag 
  to remain as compliant as possible within the framework's capabilities.
* Indoor/Outdoor for 5725-5875 MHz: The regulation explicitly permits 
  both indoor and outdoor operation for this band, so no NO-OUTDOOR flag 
  is applied.
* EIRP limit for 5725-5875 MHz: The regulation provides two figures 
  (2000 mW for 10 MHz channels, 4000 mW for 20 MHz channels). Because 
  wireless-regdb expresses a strict per-band ceiling to ensure compliance 
  across all configurations, the limit is conservatively set to 2000 mW 
  to prevent narrower channel widths from exceeding their legal limit.
* 6 GHz channel width: Encoded at 80 MHz (the widest standard-power 
  option) pending further clarification from the CMC regarding AFC 
  requirements.

Background on the unique 5.8 GHz figure
---------------------------------------

The 2000 mW EIRP ceiling for 5725-5875 MHz reflects an explicit Iraqi 
national choice that follows EN 302 502 (BFWA). This choice puts Iraq 
at the high end of the regional spectrum policy for the 5.8 GHz band 
and is included verbatim from the regulation.

Signed-off-by: Mohammed Abdullah Ali Al-Obaidi <mnew_iraq@yahoo.com>
---
v2:
  - Changed 5725-5875 MHz EIRP ceiling from 4000 mW to 2000 mW to 
    ensure absolute compliance at narrower channel widths (10 MHz).
  - Trimmed redundant encoding notes regarding standard NO-OUTDOOR, 
    DFS, and AUTO-BW conventions.
  - Clarified TPC handling limitations and indoor/outdoor encoding 
    choices.

 db.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/db.txt b/db.txt
--- a/db.txt
+++ b/db.txt
@@ -insert-after-IN-block@@
+# Iraq
+# Source: Regulation on short-range radio communication devices (SRD)
+# and devices using ultra-broadband (UWB) technology, First Edition
+# 2025, issued by the Iraqi Communications and Media Commission (CMC)
+# under Council of Commissioners decision No. 122/q-2025, in force
+# from 2025-09-22. Limits below are taken from Article 4-1-13
+# (Wireless Access Systems) of that regulation.
+# https://cmc.iq/wp-content/uploads/2025/09/Regulation-on-short-range-radio-communication-devices-SRD-and-devices-using-ultra-broadband-UWB-technology.pdf
+country IQ: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW), wmmrule=ETSI
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (1000 mW), NO-OUTDOOR, DFS, wmmrule=ETSI
+	(5725 - 5875 @ 80), (2000 mW)
+	(5945 - 6425 @ 80), (200 mW), NO-OUTDOOR, wmmrule=ETSI
+	(57000 - 66000 @ 2160), (40)
-- 
2.43.0

