Return-Path: <linux-wireless+bounces-15849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A409E1840
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C513167123
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A451DFE35;
	Tue,  3 Dec 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGIQvbWp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEF1DFE3D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219313; cv=none; b=hklJ83F9ufdSvEWS9QTHfNx8hf+CsZCvmq3foG1aepwVgX2nSV1F6xAucu7APZmG5KegQLNPfZiIbW8lotPvJDkcj/mGYaZeklk9oQIjRNco79L2+pkzvOGLPYCG5Mvy005oXq4wFRWsvPCrvxoqALa+FbSy0P1m/b9u52z7+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219313; c=relaxed/simple;
	bh=RDe8/pimVJ3ypinoyM2ZBd4rBo4g5vCyIs/smrNQSdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpZJXh5nBrk2+DdiwiGbuvDNFXPgWGyv67jB3AmfhYZDK8I9led+vum7gcTnTed+JxTvkuazOF7Sb7Jw/fknq3R0hiZAEO4DDBoFcNVESDAkzOR40nMC6HLfgLmAdBti7AhLvyi8uJtEsGknM4yQbhC1U8peiiRAwuDVQfTLEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGIQvbWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcYFnzD/H6bLNbir/uAcZ0RGwnpWZLD70cC/6A5H/H4=;
	b=TGIQvbWp8EPqb7wAkEVUnJCZdV5bpeIFZEs1B75dMEGCnx15Bp0Oq8iX66dvKGJAAk+rzB
	2kXzLvOohY2e1KoeIzwHTa0BDWMsTNR+rJoA+SuyTWcwxeFbqxMK173vNjYnY5ja0SogTz
	Hh/m4844kvbVZEadntL6FKblsi+ewJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-kQl09MV-NZCdcB4ktD1TqA-1; Tue,
 03 Dec 2024 04:48:27 -0500
X-MC-Unique: kQl09MV-NZCdcB4ktD1TqA-1
X-Mimecast-MFC-AGG-ID: kQl09MV-NZCdcB4ktD1TqA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C28B1955F43;
	Tue,  3 Dec 2024 09:48:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.136])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D4621956063;
	Tue,  3 Dec 2024 09:48:21 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Tue,  3 Dec 2024 10:48:20 +0100
Message-ID: <20241203094820.106225-1-jtornosm@redhat.com>
In-Reply-To: <20bf2693-ce53-48e9-8b54-7e3273815033@quicinc.com>
References: <20bf2693-ce53-48e9-8b54-7e3273815033@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

> Which chip do you use?
Since I am not totally sure about the useful information, let me show you
the kernel logs:
$ dmesg | grep ath11k 
[    3.659388] ath11k_pci 0000:01:00.0: BAR 0 [mem 0x84200000-0x843fffff 64bit]: assigned
[    3.659405] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    3.659649] ath11k_pci 0000:01:00.0: MSI vectors: 32
[    3.659653] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
[    4.871571] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id 0x400c0210
[    4.871586] ath11k_pci 0000:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
[    5.241485] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0

If I try to setup 2 APs with your interface combination I get this:
# iw list | grep -A6 "valid interface combinations:"
	valid interface combinations:
		 * #{ managed } <= 2, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
		   total <= 16, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 80+80 MHz, 160 MHz }

		 * #{ managed } <= 2, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
		   total <= 3, #channels <= 2, STA/AP BI must match
	HT Capability overrides:
# iw dev
phy#0
	Interface wlp1s0_1
		ifindex 6
		wdev 0x4
		addr a2:42:d2:1e:89:a3
		type managed
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
	Interface wlp1s0_0
		ifindex 5
		wdev 0x3
		addr 52:e9:be:33:6a:61
		ssid test-qe-wpa2-psk
		type AP
		channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
		txpower 14.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
	Interface wlp1s0
		ifindex 3
		wdev 0x1
		addr c8:94:02:b5:fe:fb
		type managed
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
Or even this with no AP up:
# iw dev
phy#0
	Interface wlp1s0_1
		ifindex 6
		wdev 0x4
		addr ca:e5:84:22:10:ec
		type managed
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
	Interface wlp1s0_0
		ifindex 5
		wdev 0x3
		addr 9e:4e:c5:ea:4c:e9
		type AP
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
	Interface wlp1s0
		ifindex 3
		wdev 0x1
		addr c8:94:02:b5:fe:fb
		type managed
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0

If I use the parameter to ignore the feature and configure the interface combination as before:
# iw list | grep -A4 "valid interface combinations:"
	valid interface combinations:
		 * #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
		   total <= 16, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz }

	HT Capability overrides:
# iw dev
phy#1
	Interface wlp1s0_1
		ifindex 7
		wdev 0x100000004
		addr 82:90:89:90:c1:37
		ssid test-qe-wpa3-psk
		type AP
		channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
	Interface wlp1s0_0
		ifindex 6
		wdev 0x100000003
		addr 6a:ef:d0:db:10:f0
		ssid test-qe-wpa2-psk
		type AP
		channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
	Interface wlp1s0
		ifindex 4
		wdev 0x100000001
		addr c8:94:02:b5:fe:fb
		type managed
		txpower 16.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0

Thanks

Best regards
Jose Ignacio


