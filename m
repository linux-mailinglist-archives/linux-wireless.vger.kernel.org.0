Return-Path: <linux-wireless+bounces-30627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A34D0D2D7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B59B8300A9BA
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F71EB5E1;
	Sat, 10 Jan 2026 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h+RAwMty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F22AEE1;
	Sat, 10 Jan 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768031618; cv=none; b=fj7mHo4VIxEDbtqO1WzeS28Xw1DpPObCzmkLuYGnnzk828l/f+ryC+Cuwlb1rYfDyZIx+Ayzj2Q5bKEGJHQ0VVeSRFIgc4mJXTeZmIjM1NZHNBpRbie3wKjbGzryEt6P+zEoMkAAKGz+oqp4GbQ2cDBkgnIwhQaRRc6ra4cj2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768031618; c=relaxed/simple;
	bh=pfzPB+pL+Vaucy9gfsAdG3O1/Ykt1J2u6vdmWdLKYeE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aqfs/+za9cVUUR2qybov+J6L6Dh4njC2YBGRQ4/h3YAARE1ZG5gUPwqKOk9sz3fQQlbv8LB1WHNJTK7jXocwukaqiTnCHwrRUa4QWg8DF5LH3gkGlvXFKbMQD1LyyrQTnRHqXA3Wz/bJ4Bzu/wqUYX4HCPFjgWU+GOD99FRk9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h+RAwMty; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768031607; bh=pfzPB+pL+Vaucy9gfsAdG3O1/Ykt1J2u6vdmWdLKYeE=;
	h=From:To:Cc:Subject:Date;
	b=h+RAwMtyhDUI2nXi/0H+2U7uVNTNkmdoJ/1ShdFjGryvotA8F3WMjaXlO5PnTvA34
	 pAGzedoelpj+lQSAcTQAWFYGY4O8X45nXwqBRS9cnQyqjz301xWsmShNGgzxf1KydW
	 luqs+X2myotkf5R9AbmHFha6JM+lYVo4Te/2YTSs=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.75.164])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D57B2284; Sat, 10 Jan 2026 15:53:23 +0800
X-QQ-mid: xmsmtpt1768031603t3irqduae
Message-ID: <tencent_18B0066BBCD2B63B86F511F6D01D3FA93E07@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCTc0Flu/kMd+utQTekXVhI0L8N3/XjK9rIdsjj0MBZLk3TGMrZX
	 fb1Ut2a4Rs1mwaKRSF9dh/vu5HjlhEaa/P0zkXEKya9CHrAxa2aLIpXj8NocfHVAGNLZvs/AJXD0
	 TJGHFr3UelhZnICEejuR+ERsJq+FM2/a/UE+SiVkNwxnoZi/Zuy8Q+GxYnGjF61WJRCdZrJ7LvfH
	 m2X2KQXfg4hcg8fL3GgmSuKZ3inHsJNRdOYnKpuaFPjkxpK9B8BK50SasBurhYN+QP/+zYl2bXGC
	 2qOsK4cn31KDv/S1XhyAy9ge8gYn/WqSUVPZdnsQsSV40SYvMBiVArF0Ajw4Au3+t8p2prUSOS5I
	 duM3R0gRQGuoUAWkv/gNxgLWJtE3TMq8fWxEEuqLk/ZivC/6JEmmRs6m3mbYSbY8QNeNUqnbIKFF
	 mJsGbKeoufuo0fCnPzAHZa2XobsHvQFHZKQcp2jH5PHjHYvL82vOQS8Df9ieKNyJsfxcw20H6S3s
	 RsYy9lH9HpEK1YuNu27U4Zj8zJPmVh6wlGL+SlFV4pZgbYXg/CwMi8Dvl8e/FgoEDlrSSNwQ7Dem
	 lVshHB/H32lPgo5GsFt4wqd0yIiFb9m0k/QeMXsWFNWYBVs+UcgMGsXGpo5FJAdE+1ygrmUBMJ2O
	 90Za/copknZb2xUsrdsO358gbM1SqZYAh3CzGoqel7fuBvB66DtalAX50cu3nJxYxrX2TtHqsgz/
	 sfuUqCsgAC5I9sCqrpNghMhcX38JEG4KTanDxLauCdSNXv9qChhfjxGtU5e3SD+GvdPQUeYQjvAx
	 jWaZiLPgjnMhgXrJsVMmxzSVZ/rld+nxqXN5L3YQD9Behl4mGK2RVFcKTsJtuEaKENy0upHFY6Ks
	 Bja2Vjo8fWlxExgyLNc0/4aSjUBdWV6Pj/0gmIUeweFK7bpaWsx01kJUhgnd87l1lC/Heu5q1MnI
	 yxIs+uei77e97QbAFaRA9qO8YepMkXfiMXNZK7gXWCFysBH9rBR7zy02r2rcd6F4a8ae0zffz4U7
	 CsfNII8AdNZWxxKoqyVGlMutK/nRs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: cjz <guagua210311@qq.com>
To: guagua210311@qq.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PING] [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and replace global io error var
Date: Sat, 10 Jan 2026 15:53:22 +0800
X-OQ-MSGID: <20260110075322.4857-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

I'm glad to inform you that I have just successfully resent the complete v4 patch series (with "RESEND" tag) directly to your mailbox (gregkh@linuxfoundation.org), since the original linux-staging@vger.kernel.org address was bounced.

The patch series optimizes the rtl8723bs driver by:
1. Removing redundant atomic_t operations on continual_io_error (no concurrency scenario, atomic ops are unnecessary);
2. Replacing the global continual_io_error variable with local error_count in SDIO functions;
3. Cleaning up unused old functions related to io error counting.

Thank you very much for your time and patience! I look forward to your review comments.

Best regards,
changjunzheng
Signed-off-by: changjunzheng <guagua210311@qq.com>


