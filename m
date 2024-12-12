Return-Path: <linux-wireless+bounces-16319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB809EF87A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5039D18848F3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD50222D68;
	Thu, 12 Dec 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gJT8tylM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D62153DD;
	Thu, 12 Dec 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024792; cv=none; b=uTSElMe1otI2btMMQSGI9WNvCsSfAvyGwFPUEh7efJNmzlftoU3dZ2ZhK4QeYoKpgDbj75NqgHGAVnE2skodnBzvD06Y6hmmZK97oe5K4VvU7nLzqlOHCSplcrcCZ7rQ4O+GYStl5NsGHvj3PHfv2D15VXsvEjPcHOhnUj+Bf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024792; c=relaxed/simple;
	bh=R5JFd69wz+34MsBBdxu3c/nOib3KiRU/jllGTF4pL8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Re9HW3okDV8KWAe4uSYn2+e57b1AYZuV6zjC0BL3C0ei7N206Izw1UjKq8YwrF/+Z4Ih5NzbpoO7DvkUMvPY2wPx74tXqXhYxJ4LU0G4W18gqU7h3kf6It7XNwb6qFZSd59na38LbjAPrGsxjskzVMt8n1otDgoPL/dRBxYGkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gJT8tylM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9FC7F20ACD6C;
	Thu, 12 Dec 2024 09:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FC7F20ACD6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734024790;
	bh=j8AmzIEjYIQS6zN/bjVcHRxb12g3/9cjkDw7Uf+bRaw=;
	h=From:To:Cc:Subject:Date:From;
	b=gJT8tylMA9p8ykATh8M7TBp8bG7wrLTBVChrEcO+8CYjky2IreuL7Ww1JIgrqe0TJ
	 HmgK0Wa2KtnbepWHfjoD7K4cLnpv39lVLmv1GQD37mLACLyU2fd6TS/gCPPalZTK9Z
	 iCLN3g+6to3teWWxrd32CjLWy+LooyBdQ01pTIyQ=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH net-next v4 0/2] Converge on using secs_to_jiffies() in netdev
Date: Thu, 12 Dec 2024 17:33:00 +0000
Message-ID: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241211-netdev-converge-secs-to-jiffies-f18b18c775c1
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable

These patches are pulled out from v2 [1] and v3 [2] of my series to be sent=
=0D
through netdev. The series converts users of msecs_to_jiffies() that need=0D
seconds-denominated timeouts to the new secs_to_jiffies() API in=0D
include/linux/jiffies.h to avoid the multiplication with 1000 or MSEC_PER_S=
EC.=0D
=0D
[1]: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-0-911fb=
7595e79@linux.microsoft.com=0D
[2]: https://lore.kernel.org/r/20241210-converge-secs-to-jiffies-v3-0-ddfef=
d7e9f2a@linux.microsoft.com=0D
=0D
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>=0D
---=0D
Easwar Hariharan (2):=0D
      gve: Convert timeouts to secs_to_jiffies()=0D
      wifi: ath11k: Convert timeouts to secs_to_jiffies()=0D
=0D
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 6 ++----=0D
 drivers/net/wireless/ath/ath11k/debugfs.c    | 2 +-=0D
 2 files changed, 3 insertions(+), 5 deletions(-)=0D
---=0D
base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07=0D
change-id: 20241211-netdev-converge-secs-to-jiffies-f18b18c775c1=0D
=0D
Best regards,=0D
-- =0D
Easwar Hariharan <eahariha@linux.microsoft.com>=0D
=0D

