Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0342DC6B6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgLPSqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 13:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731874AbgLPSqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 13:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608144278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SKYDss7PxZFgt1jeP63b9jeFcKC3PBd+1GqytdVAcMw=;
        b=U8V2T90sizHqbzp3HRxTLlrpT0KK2CUaXQXYBJuMsxfd3YrvFLo49lVGuSfiq+Ega3rn8d
        B+7pAJfcuU9IRR3U9SWZ4I8cS0NgFJ9bLw+UItX+SWRI014NjlEoSywMu48jZugjTnUhB9
        Qr2jm2eRHwRG6ClLIr0+4gOoTD3z7bs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-JOZ4qQAXPlO-_NsrOlBdDg-1; Wed, 16 Dec 2020 13:44:35 -0500
X-MC-Unique: JOZ4qQAXPlO-_NsrOlBdDg-1
Received: by mail-ot1-f72.google.com with SMTP id q5so11419119otc.11
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 10:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SKYDss7PxZFgt1jeP63b9jeFcKC3PBd+1GqytdVAcMw=;
        b=eHVR3l1rT0JhPEndAaUAEzp6ykzN3DnvxN57HvYJ7ermqxWbzP07ywo+lWe4sZcPYk
         Pgdw4rwQHVIIJuJDg8PzbhfviZHvneDGPEfkGlbOinL4c0YwuaxIsDUnNSxs/woE3bwK
         lmPQ5h/jIQYHT+vl3WvOa/+emM3Obkeqlr1pVvo0rY95q515esdBdqN6PySTEQHlApYN
         veOCLmFynAS6xK2u3viaUJ9GnQ13fbJMB7nzzYoc8Tof67GU/Mzenslkmx/yuuKABjtm
         FDtcJw+m8ZSHY0ST6bKccxXKvBat2DLn+hvPzIX6Co8jhtpGyCDHtseqwq675TknoDNd
         NcLg==
X-Gm-Message-State: AOAM530tQdJ3GSEdXOoLAKy0Vl3nfyCNI0fNQz31CSYy/G0dWwl5OFww
        EBkioESF5ZBcpPJNiTQFlSPWpyNuejhNRMZjAXoXudnZWWVSCoDrjSgnjBijalcJ2uGi8qUySht
        KqCfESR39Mc6DtBo1GxofR/7Zsc4=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr27108602otd.208.1608144274309;
        Wed, 16 Dec 2020 10:44:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3gqYYB8pVhUOLCDK1/z/qYdCVLR+GelETsBfdXoe0XY+wd0j1sWHfGotqZFG8LsRRTidsRg==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr27108593otd.208.1608144274165;
        Wed, 16 Dec 2020 10:44:34 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id e10sm620574otl.38.2020.12.16.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:44:33 -0800 (PST)
Date:   Wed, 16 Dec 2020 19:44:29 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Fwd: [PATCH] mt76: mt76u: fix NULL pointer dereference in
 mt76u_status_worker
Message-ID: <20201216184429.GG2036@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--uJWb33pM2TcUAXIl
Content-Type: multipart/mixed; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kalle,

Since net-next is closed now I guess we can consider this patch for
wireless-drivers

Regards,
Lorenzo

--Dx9iWuMxHO1cCoFc
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: lbiancon@gapps.redhat.com
Received: by 2002:a05:7110:b009:b029:2b:a2b7:c4e3 with SMTP id f9csp3114677ged;
        Tue, 8 Dec 2020 01:20:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4W548yCJvKMv0NwjJS/0GlxQ65efbxvr2DDA1Mkhqa0bTtotDFRBo+qXM43TCKFKTJAYs
X-Received: by 2002:a25:4409:: with SMTP id r9mr25504217yba.113.1607419234821;
        Tue, 08 Dec 2020 01:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1607419234; cv=none;
        d=google.com; s=arc-20160816;
        b=eTujs0KzJkxGm+Cw721UFlA+/qoptkUSEc2Vpoed34EVcjuw7bD15l/iJK/KR4N7Lf
         O80s/MwVJwM1g5pP/vyJ3gG7LHADUc9c9dpVksE5A36jDJOURnz0nai7x772brABsnKA
         nIHpyX53HtBJSjMJGJyQQxXfJ4S5wJ3RaYg5bPiRTnztcrw+tZqvPDKaCq+lK+8jggIp
         Vz1x6p29YUHzvuzimzR1KAQgDeSZbWqF3DbFC8CQcaiDab70Lt+xRI9o+Ij+38qYWNys
         jGTdI1wr1/RsFkbcGYNRhIJyzmchHTOUl3DoiGzAyGPs878zNffiAnkje46J+ccUVBMS
         t3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:delivered-to;
        bh=0EUDhczJdR7KWMIvh6GGP43rTpbJCiUxS9hpVfGlL5U=;
        b=O8fHSVbcM03o5oEMAUkkOBvrD5vfgZherc446KDCvBr9R9oPQ4d26wqARTTyF1nxYg
         yoxA2XquqH717clF1+5WU8Tsf4qdyvsZXUf2HVIygfZ+DHuwPB6mI0gIRjVEyzXVpnuD
         BxeeGY4aZpBo1N3C1IQXtEBOOqbSOCT4M1Eg9gDRpinqJGagLuOP79o9m3+vKpaWqFTq
         OZ3prP/MP1GCjp4ldmfStjQ5zWn1OvvCEyqTMRZHOpWZba5rIjxwZJdwOxwXX/G4B4lL
         LeJMicjBENEK3Xca8qz8jkiE2RRrUq5a6gj19pPF6I6CR1gGt/D9S2MUOUfAxCm3jgfv
         xyxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=lorenzo@kernel.org
Return-Path: <lorenzo@kernel.org>
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com. [205.139.110.61])
        by mx.google.com with ESMTPS id 201si10620891ybf.130.2020.12.08.01.20.34
        for <lbiancon@gapps.redhat.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:20:34 -0800 (PST)
Received-SPF: pass (google.com: domain of lorenzo@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=lorenzo@kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-6dC8t6X8M1a1l41K43Ijig-1; Tue, 08 Dec 2020 04:20:33 -0500
X-MC-Unique: 6dC8t6X8M1a1l41K43Ijig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AEB58007DF
	for <lbiancon@gapps.redhat.com>; Tue,  8 Dec 2020 09:20:33 +0000 (UTC)
Received: by smtp.corp.redhat.com (Postfix)
	id 17A889E66; Tue,  8 Dec 2020 09:20:33 +0000 (UTC)
Delivered-To: lbiancon@redhat.com
Received: from mimecast-mx02.redhat.com (mimecast06.extmail.prod.ext.rdu2.redhat.com [10.11.55.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1266E9E63
	for <lbiancon@redhat.com>; Tue,  8 Dec 2020 09:20:33 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 010111871CC5
	for <lbiancon@redhat.com>; Tue,  8 Dec 2020 09:20:33 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99]) (Using TLS)
 by relay.mimecast.com with ESMTP id us-mta-105-n5iDbQzpOAWeSESyOdqQ1Q-1;
 Tue, 08 Dec 2020 04:20:29 -0500
X-MC-Unique: n5iDbQzpOAWeSESyOdqQ1Q-1
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org,
	lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76u: fix NULL pointer dereference in mt76u_status_worker
Date: Tue,  8 Dec 2020 10:20:15 +0100
Message-Id: <cd44dc407cf3e5f27688105d4a75fb1c68e62b06.1607419147.git.lorenzo@kernel.org>
MIME-Version: 1.0
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection Definition;Similar Internal Domain=false;Similar Monitored External Domain=false;Custom External Domain=false;Mimecast External Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat Dictionary=false
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
X-TUID: aldEsFaCk+1x

Fix the following NULL pointer dereference in mt76u_status_worker that
can occur if status thread runs before allocating tx queues

[   31.395373] BUG: kernel NULL pointer dereference, address: 0000000000000=
02c
[   31.395769] #PF: supervisor read access in kernel mode
[   31.395985] #PF: error_code(0x0000) - not-present page
[   31.396178] PGD 0 P4D 0
[   31.396277] Oops: 0000 [#1] SMP
[   31.396430] CPU: 3 PID: 337 Comm: mt76-usb-status Not tainted 5.10.0-rc1=
-kvm+ #49
[   31.396703] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
3.0-3.fc33 04/01/2014
[   31.397048] RIP: 0010:mt76u_status_worker+0x2b/0x190
[   31.397931] RSP: 0018:ffffc9000076fe98 EFLAGS: 00010282
[   31.398118] RAX: 0000000000000001 RBX: ffff888111203fe8 RCX: 00000000000=
00000
[   31.398400] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff8881112=
03fe8
[   31.398668] RBP: ffff888111201d00 R08: 000000000000038c R09: 00000000000=
0009b
[   31.398952] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   31.399235] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c9=
87300
[   31.399494] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:=
0000000000000000
[   31.399767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.399991] CR2: 000000000000002c CR3: 0000000103525000 CR4: 00000000000=
006a0
[   31.400236] Call Trace:
[   31.400348]  ? schedule+0x3e/0xa0
[   31.400514]  __mt76_worker_fn+0x71/0xa0
[   31.400634]  ? mt76_get_min_avg_rssi+0x110/0x110
[   31.400827]  kthread+0x118/0x130
[   31.400984]  ? __kthread_bind_mask+0x60/0x60
[   31.401212]  ret_from_fork+0x1f/0x30
[   31.401353] Modules linked in:
[   31.401480] CR2: 000000000000002c
[   31.401627] ---[ end trace 8bf174505cc34851 ]---
[   31.401798] RIP: 0010:mt76u_status_worker+0x2b/0x190
[   31.402636] RSP: 0018:ffffc9000076fe98 EFLAGS: 00010282
[   31.402829] RAX: 0000000000000001 RBX: ffff888111203fe8 RCX: 00000000000=
00000
[   31.403118] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff8881112=
03fe8
[   31.403424] RBP: ffff888111201d00 R08: 000000000000038c R09: 00000000000=
0009b
[   31.403689] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   31.403933] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c9=
87300
[   31.404209] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:=
0000000000000000
[   31.404482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.404726] CR2: 000000000000002c CR3: 0000000103525000 CR4: 00000000000=
006a0
[   31.405294] mt76x0u: probe of 1-1:1.0 failed with error -110
[   31.406007] usb 1-1: USB disconnect, device number 2
[   31.840756] usb 1-1: new high-speed USB device number 3 using xhci_hcd
[   32.461295] usb 1-1: reset high-speed USB device number 3 using xhci_hcd
[   32.659932] mt76x0u 1-1:1.0: ASIC revision: 76100002 MAC revision: 76502=
000
[   33.197032] mt76x0u 1-1:1.0: EEPROM ver:02 fae:01

Fixes: 9daf27e62852 ("mt76: mt76u: use dedicated thread for status work")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireles=
s/mediatek/mt76/usb.c
index 7a91fd0c2b01..b95d093728b9 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -815,6 +815,8 @@ static void mt76u_status_worker(struct mt76_worker *w)
=20
 =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
 =09=09q =3D dev->phy.q_tx[i];
+=09=09if (!q)
+=09=09=09continue;
=20
 =09=09while (q->queued > 0) {
 =09=09=09if (!q->entry[q->tail].done)
--=20
2.28.0


--Dx9iWuMxHO1cCoFc--

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9pVigAKCRA6cBh0uS2t
rPwYAQCHp4RW0LcCLsEuU+Y5QnU8CYYFbl5Mr1gmFQWHveTfgwD8D5Qm7Rzj6fdH
RKOlfdhb7+5POYT851I4G+HTWfRyIg8=
=uHlc
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--

