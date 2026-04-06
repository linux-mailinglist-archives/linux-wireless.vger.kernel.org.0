Return-Path: <linux-wireless+bounces-34378-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEp2Miz/02lypAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34378-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:45:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C833A651D
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB153300C0D2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4643947BA;
	Mon,  6 Apr 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHlKfhBB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8D31715A
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501093; cv=none; b=r683Nv0ZQMVhHWBvCOmYgMBzZtQ5HPswo4j3NT1q+PgDe72M0w6REw2i/50D7o7CThCziCrXOYDl6VOWx5Eu2jkgmeW/YuvExel4fsedLNkORQrBjWXSnUft5rPBTr6/wdBJizqzR6uce+BW6dRO6P9zJkLjYluv/9XRT/ayfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501093; c=relaxed/simple;
	bh=1wFdMyFvSWKZhsBw4bUJanuljFszLvuCcEbWOUJntAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bb+rwX8+cc5fuESk0u68BLOiOFkj8ot2kb7FQVdhg3ufLCr0PWstPw+MqkKml1i33pG1KFPkJm+qrZZSPhjM5WFRDPuS2qDyZtavxZlFEnP+mb9+IOLWRkZU15O7muEOnyz1k0+nAtEMuvwnPaLK3i9/znc04MsHEQKB6xlGrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHlKfhBB; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-650789b22e3so331390d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501090; x=1776105890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1TFbzSmIgRxkU6nP06w6dExgV+CzgxbPMmRj78Eh2I=;
        b=dHlKfhBBpPNnvSukZX8+8/9ZaHHJBxkkfGgpaaWQ2EMgkh4ZP5hB4TGWQBk6lBmAJ4
         TtnrYOmc3zcRSpEra9wAJ2iOZiGt2YYs346c/QXd6lXIqc0aukb9U1kP6QOK9oIFm1lA
         4URXfiUTROE8tAqhN2kRDkTcDtLF0wpqxUVpXWxX2sEZz99NnHsoNWT+3NkY2ZSSW71v
         YIVHqkX8gIJbC6se1GhsB9PF1oqcxoqGN5RSzKnSWP0clepx4+lrQ8z6VkNXIurgtfZD
         g9DOs75Y0ovnsd3uL6KM3LaGFeLpMw+d0gR53f+7/rNYn7JrtY8bvw/mD0Gd/iyOaU8T
         IiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501090; x=1776105890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1TFbzSmIgRxkU6nP06w6dExgV+CzgxbPMmRj78Eh2I=;
        b=M38LXx4XKya+EnerJwnlxrkK95z/+LGug+lbaXmXriUNNTDBGzOVd/GzCEQ0NtxWft
         030V15bCMjnuBO7UkbaNpmhRQtPOKO5npOoVmNpxLYS3swSlRSCo+5wh5jgggPYCN1+W
         l2xKKHxiEL1RNoXiC5RFlz6Pvb3w47/08nOyRyyQqoKb7KFNc+hozdTdQCwn84l24sXx
         gXw+Ht+02Qs/0IZ8ZIak6CEWKmuhLtJKcBxWKWojxY6m0gP2Gkvam4RxfHT/Je4cRhmh
         R/x4g+EhcciaHSecwKU6lUKrnzKJBI5ZJ87yNo63j6ZXpzf9olnJ8RGgzoTctDiaY7DS
         vetg==
X-Forwarded-Encrypted: i=1; AJvYcCXwragt8nMOh29qKA5Y1d3FxJ1hjNiFXGgsQ27Vtwa2chnbC6ZwSJIvJFNFJaD+v4Y8kbZ8XmZ3F7EWR/RTvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBZWFqFNlT1wIkWsVW9rCsJTd61DnrdVCWjNKh7x0hnowIy4v
	bTrwotS1f7kRQppen7ExeRX2kSL4zk3DMaokVG/zIFSQ/NJFjr6+TO5R
X-Gm-Gg: AeBDievPmbEJTf8KDsfyishYuCskld3/PuJRo3uz4IeLRlyTlOTckuQuDcwu/S6aSim
	dEeesACl2zYSmxZdvDjqoPNzSF8bejy5mnCO5gPl/5jNMp54SXWQOzfPIFbhFFeSx0xcva1t9rf
	4JGbhwip/H4vq4wx9/9Cxlco0p98t67T8Ii4+gU+hrDLSMbUz+b4FRwj0eYn5qYOxhFNYV9dVK7
	nuOcOz+mKpiYcFOQKEuG340gTeD4KBLfC3ykI/yZ0X2W6Hy6Jets/Hn/Y5nvkgFI9Uky4YrTo1J
	RUarG3wrbBsfzDdsYatMzzPCxssHTNPpb7JSOd2q3tzO3iAUaaINKUP2++5itk/VWti1oQ2AmTa
	J2xh9op4lpO0OV3KKJ1GgPDycTzkfPZRVqFzqkwZRwFx6Jwvfrg83h7FrVM0AMg9W4RYJScupVd
	UslOpEHYzJyVdzGHRuXfyaQNMY46ACrNLnmfkryIKFiyblLAca/X8fMd5mcYHE
X-Received: by 2002:a05:690e:d48:b0:64c:a6c8:5300 with SMTP id 956f58d0204a3-6504886b02emr11564131d50.34.1775501089848;
        Mon, 06 Apr 2026 11:44:49 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9a9271sm6342830d50.15.2026.04.06.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:44:49 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH 0/2] wifi: mt76: validate WCID index before WTBL lookup
Date: Mon,  6 Apr 2026 14:44:04 -0400
Message-ID: <20260406184406.8152-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34378-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71C833A651D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt7915 and mt7996 drivers do not validate WCID indices
extracted from hardware TX free events and TX status reports
before using them for WTBL MMIO register accesses. The hardware
WCID field is 10 bits wide (max 1023) but the actual WTBL
capacity is only 288 (MT7915), 544 (MT7916), or variable
(MT7996). An out-of-range index causes a kernel data abort.

Reverse engineering of the MediaTek WA co-processor firmware
(NDS32/FreeRTOS) confirmed that the firmware validates WCID
for its internal table (< 786) but still emits out-of-range
values in DMA descriptors sent to the host driver.

The mt7615, mt7921, and mt7925 drivers already have these
bounds checks. This series adds the same validation to mt7915
and mt7996.

Joshua Klinesmith (2):
  wifi: mt76: mt7915: validate WCID index before WTBL lookup
  wifi: mt76: mt7996: validate WCID index before WTBL lookup

 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 6 ++++++
 2 files changed, 12 insertions(+)

