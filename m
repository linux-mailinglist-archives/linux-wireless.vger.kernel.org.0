Return-Path: <linux-wireless+bounces-30184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FADFCEAC97
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30511300A1F8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE2263F54;
	Tue, 30 Dec 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="fN68nmOu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859881A2C11
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767133912; cv=none; b=Nc4rgzWTnFzEWkbUNlIg9GezIRgmBTFXTSvXKkCd4HmFYcDS3QQRDv+bHHZyHjDsEHVfDyzsY+CCcpwtmqR6d8l9WatTo0IsHTzC70QSEdvYqHAG37pxvT2EatHZZsQv+YOFGAsOzaFTFJo4f6idGN51gMRsE5vfH+FTlcen8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767133912; c=relaxed/simple;
	bh=F96QIsh6283nu8dS1KXhB4IVFcLib3QwH/qyxaLbdE8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=qbszLBzl6U8CKaNSouplsIEqq5Lmv9LU6NdcOgSgyBTTmxkSKwYdkhdCEQk2JrCykYaEt6iNb9hYjr7spgJe9vt9WWHWcu7foBl+vbVUiwbvvYuw+QaRoxBA3d/m/5H2x0GNXb+JwDjHM4zjMuWkAfupWEjH7FaTD62HUnjSG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=fN68nmOu; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=F96QIsh6283nu8dS1KXhB4IVFcLib3QwH/qyxaLbdE8=; b=fN68nmOuORtR9+LVSk653So8xR
	odUOeonGwu6FwGpiaNXQsBNjShQyJ0NL98C2AHM52+8i1BpZ6Se1kOZuv8VIlr/bqXap23Ef/Ka5V
	CdT/NVIl011VL9thfwykdTBLMqc8N/gmy/ghjSZufWGCYd2DwIRghllEI21TUeLmYoWhaT4aLXO8l
	HLlaeF2NDvwLvSnir5Q0vwChUhnzdfKVPxabKsixeH+pfdy2edx2cCOXzLqh/ogPh1vDxzspxcHt6
	rigOsOuyyUuuj70UGUYLzkMmFB4T1H2KlXfw+dvETV+Sclnb0fLL/SYlPLeoxPyZIpHr9Z4GLi2ol
	3413ulHQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1vaiFm-000HUS-32
	for linux-wireless@vger.kernel.org;
	Tue, 30 Dec 2025 23:31:47 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1vaiFm-0008Xb-2E
	for linux-wireless@vger.kernel.org;
	Tue, 30 Dec 2025 23:31:47 +0100
Date: Tue, 30 Dec 2025 23:31:45 +0100
From: Thomas Meyer <thomas@m3y3r.de>
To: linux-wireless@vger.kernel.org
Subject: 6.18.2 iwlwifi broken, API version 4294967294
User-Agent: K-9 Mail for Android
Message-ID: <72464EF2-D744-4151-AB30-96C1EA41B482@m3y3r.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: Clear (ClamAV 1.0.9/27865/Tue Dec 30 08:26:00 2025)

Hi,

This patch broke my laptop's wifi:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/drivers/net/wireless/intel/iwlwifi/iwl-drv=2Ec?h=3Dv6=2E18&id=3D5f708=
cccde9d1ea61bb50574d361d1c80fc1a248

The API min Version is shown as:
Driver supports FW core 4294967294=2E=2E2, firmware is 2=2E

Looks like some integer overflow for my old hardware=2E

Reverting the patch makes the driver work again=2E

Mfg
Thomas

