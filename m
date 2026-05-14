Return-Path: <linux-wireless+bounces-36409-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDThAGFpBWq5WgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36409-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 08:19:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA653E3EE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 08:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A90ED3038BB8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5B3932D5;
	Thu, 14 May 2026 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGOcCj39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685713ACA5A
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739534; cv=none; b=UGOfDN9Zn6ruB5LYVhwoZ82AlGagQwyiCKnca30BULyo0YzFZLShJfZzjKpdMIvLIuNn7ebg0nrrRzUoUhm5vgIZGvmLlry+/p7jRxFbu64KEY11iP8I2hmdaPk82u4lF/uEaqxXCICm9ObuAojPKS0Ub9QKVjIqaKVwUC/1FDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739534; c=relaxed/simple;
	bh=71nKI1Wj3adc1WFn8mrqz2Le/gBm5yHAgiVE3gL2oys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvWcuaqAQGVPhGfrF9BeKMBs7Q74WgyURNg8oupge2ks4pHAADTTvimjtdZ54rqrDV/dVF6fWcTZHJ5Vo+qI5RLPbGuiF29qy3ukK0fPoQXYPAECHwwLsRL8JKB5NvKm/ntZYena/mvDp02G3Sgjjdd5lEBu4vFD7yGacNu9rlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGOcCj39; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778739532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx9J2zQCCR0v83fPqRH4Wf+USVyuXb4hC/B1FjQBSfM=;
	b=CGOcCj398QVrLzbE8g3FGXEUS4ZDCMga1Xj4BhWRR86Afs+fy3fP3PEtfBRU7kNLbVzaj4
	uXha6EYz3lQLU9saX+zPvLSexBIRYeE+RNj3EW2kcvxVvZs2e4ZUEVmi7hsU8NX+v8rmHN
	fbwiLYRow532Grfi8SKV+4tH6hsFlpE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-eSeZBx29N8Oz51wzAnDxAQ-1; Thu,
 14 May 2026 02:18:48 -0400
X-MC-Unique: eSeZBx29N8Oz51wzAnDxAQ-1
X-Mimecast-MFC-AGG-ID: eSeZBx29N8Oz51wzAnDxAQ_1778739527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3F0119560AA;
	Thu, 14 May 2026 06:18:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F2E71955F22;
	Thu, 14 May 2026 06:18:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	rameshkumar.sundaram@oss.qualcomm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
Date: Thu, 14 May 2026 08:18:40 +0200
Message-ID: <20260514061841.9517-1-jtornosm@redhat.com>
In-Reply-To: <20260507070808.367442-1-jtornosm@redhat.com>
References: <20260507070808.367442-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 7BAA653E3EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-36409-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello Rameshkumar,

> I agree that setting tx_status to NULL makes ath11k_dp_free() more
> defensive, and it matches the ath12k fix.
Ok, I agree too.

> However, i am still wondering how the second ath11k_dp_free() is reached 
> if ATH11K_FLAG_QMI_FAIL is set.
>
> In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
> qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:
>
>     ath11k_pci_remove()
>       ath11k_core_deinit()
>         ath11k_core_soc_destroy()
>           ath11k_dp_free()
>
> should not run.
>
> So if the double free is still reproducible with QMI_FAIL set (with the 
> change i proposed), either the flag is not actually set in this failure 
> case, or there is another path calling ath11k_dp_free() ?
Let me try to clarify the issue more.
There are two error actions:
- First the previous error. I reproduce the situation as I commented: running
in a VM the default upstream kernel (with this card using PCI passthrough),
since this is always failing. Let me show the logs in this situation:
[   15.906564] ath11k_pci 0000:07:00.0: BAR 0 [mem 0xfdc00000-0xfddfffff 64bit]: assigned
[   15.926520] ath11k_pci 0000:07:00.0: MSI vectors: 32
[   15.928572] ath11k_pci 0000:07:00.0: wcn6855 hw2.0
[   16.984192] ath11k_pci 0000:07:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id 0x400c0200
[   16.984351] ath11k_pci 0000:07:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
[   18.186971] ath11k_pci 0000:07:00.0: failed to receive control response completion, polling..
[   19.211036] ath11k_pci 0000:07:00.0: Service connect timeout
[   19.211815] ath11k_pci 0000:07:00.0: failed to connect to HTT: -110
[   19.214181] ath11k_pci 0000:07:00.0: failed to start core: -110
[   19.531989] ath11k_pci 0000:07:00.0: firmware crashed: MHI_CB_EE_RDDM
[   19.532930] ath11k_pci 0000:07:00.0: ignore reset dev flags 0xc000
[   29.259157] ath11k_pci 0000:07:00.0: failed to wait wlan mode request (mode 4): -110
[   29.259229] ath11k_pci 0000:07:00.0: qmi failed to send wlan mode off: -110
- Second after this, I commanded the unbinded (ath11_pci) and I get the
warning. Let extend here the stack trace:
[   24.238198]  ? free_large_kmalloc+0x57/0x90
[   24.238199]  ? report_bug+0x16b/0x180
[   24.238210]  ? handle_bug+0x3c/0x70
[   24.238218]  ? exc_invalid_op+0x14/0x70
[   24.238218]  ? asm_exc_invalid_op+0x16/0x20
[   24.238224]  ? free_large_kmalloc+0x57/0x90
[   24.238227]  ath11k_dp_free+0x99/0xb0 [ath11k]
[   24.238275]  ath11k_core_deinit+0x12b/0x1a0 [ath11k]
[   24.238287]  ath11k_pci_remove+0x7b/0x120 [ath11k_pci]
[   24.238294]  pci_device_remove+0x3e/0xb0
[   24.238304]  device_release_driver_internal+0x193/0x200
[   24.238315]  unbind_store+0x9d/0xb0
[   24.238320]  kernfs_fop_write_iter+0x13a/0x1d0
[   24.238330]  vfs_write+0x32e/0x470
[   24.238335]  ksys_write+0x5f/0xe0
[   24.238336]  do_syscall_64+0x5f/0xe0
Very easy to reproduce.

Anyway, although you can avoid a specific path, IMHO this small fix is
recommendable to avoid other similar situations.

Thanks

Best regards
José Ignacio


