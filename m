Return-Path: <linux-wireless+bounces-27186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76AB4FE71
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEAD3BE587
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34823F422;
	Tue,  9 Sep 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D2s6Kata"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7A338F36
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426274; cv=none; b=b56iIo/iejoM6uz+VFnD6hXdwKaK5IhByVPldFPfWSK67C27arIi7YhHWe2G16q9YbrHUuhuOXPK5h7P+GDke0wVwzZTIe7Y8XCwYLfyHps67ZO5JDJh1uo/bcN8n8l1peveSB7FDpF6CrsWz6+u5Mcl3Gm63hJUtLwADcmqSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426274; c=relaxed/simple;
	bh=zIVdSeU2bSylbjXe19dmWToNdUlbK48wNCtsAMN9Hc4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IArIFobOqpT5hJBZAJKdkrRnU4U0tF1l2th4UEObjccsjPgqMrZpyz367l0wtSel5E6p5tQVBRcfQgy7BRgOu5hSxrPPcyJ9FWz9X5mxD/PGXDHe6wirMfMnOxBo5L5nhlPmli8qneS8DfO/HDuwHNzGygmjCiqyBe8Gl1DipLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D2s6Kata; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zIVdSeU2bSylbjXe19dmWToNdUlbK48wNCtsAMN9Hc4=;
	t=1757426273; x=1758635873; b=D2s6KatanuQ4mrOPVXWWBZVRbkRGPUHcpF5uecg5TUKSCKp
	agB9A7RrkcpZADeYT8N1/NionZBOTxnpg1L5hSfyVKGFzeMH6c9mCkmHp5VK51j0IsAKvY3PGapae
	Dm0xRurIuj4SucWgK/RcMKxPoze7F9tBL9FcngvMK4JS9PwfEUArvtZH6QiU9fbQ8t8bv1Z7mSqBu
	rJFSSXIyJKinDyciRQjOlzQD1lA8iCUQM7a36TcQ8rUpL9fGMErtFTa4Y1ObVnc/Fu9vypUn/NXPM
	2uRhNVM1l5QfEYNXe44qDFAR+y0etKkL0CowcKAkbH/MfMEyGKnncnUJoh90lmdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvyr0-0000000AQBb-3VVD;
	Tue, 09 Sep 2025 15:57:50 +0200
Message-ID: <8d5d8339f1dd568f43d97c4ed60817df1838fc13.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: always mark 6 GHz BSS as QoS/EDCA
 capable
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Isaacs <scaasiffej@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 09 Sep 2025 15:57:50 +0200
In-Reply-To: <20250909135510.757750-1-scaasiffej@gmail.com> (sfid-20250909_155641_396397_537D7D64)
References: <20250909135510.757750-1-scaasiffej@gmail.com>
	 (sfid-20250909_155641_396397_537D7D64)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-09-09 at 09:55 -0400, Jeff Isaacs wrote:
> In 6 GHz, QoS/EDCA operation is mandatory as per IEEE 802.11ax/802.11be.
> APs are not required to include a WMM Information or WMM Parameter
> element in Beacon or Probe Response frames, unlike in 2.4/5 GHz.
> Instead, stations must assume that QoS is always enabled and use EDCA
> (default EDCA parameters apply if no explicit EDCA Parameter Set is
> present).

What? You really need to back up that assertion.

johannes

