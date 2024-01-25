Return-Path: <linux-wireless+bounces-2472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F4283C1A5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C162B23411
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227B36123;
	Thu, 25 Jan 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="b8oByd2g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67136122
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184516; cv=none; b=W9SfhwJSQw5D4+mPe0cSGkMO/Xv/yWz4UOqvcetB9n/ezfaNhSKO7SZE9Z2GGbaa5o6cuh7V85l5wyz30SFrJ/3JqsDbflbJXmwpoavUIqQ35PBxuSEFdv7SaojYkDiGUyCt09CgEprqyQtHGy7G7FvGahwYPtfN0IbLGmN6lCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184516; c=relaxed/simple;
	bh=5cMGzNpjXAbRQOch6NYuEQvZ3cL/K0bkKmKwG/KAHtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8mnh5SKHEYON+5Y5fCjBCvXIqIHiRcdiP+nQQd9h4QbOZSVeqNUk9bROr7HjZvfJbJ5cGYrnGkt5C6fE9O6fsFy8oUNF1DrrEiQd7aOkrqQ0d9swRRzkhdUPqsQGmvxYcc7ojl24jYVRN9vNt7Mqe0hnOKeSDVWRmVM4TZHF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=b8oByd2g; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2a0c:0:640:2804:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id E299360A5D;
	Thu, 25 Jan 2024 15:08:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M8TQNP9f9Os0-dNXLuOwY;
	Thu, 25 Jan 2024 15:08:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706184503; bh=5mcAV5B2jtpfi9KBBXVQ83daVBIsCifehGGT1y35w2k=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=b8oByd2gZG4m7rxXG86qID8jBQ+7a3K0xmpJNGhNgx0jkgxf4f/MRp11LDRUntDj2
	 w3sbln6tSv/+Jag8ELipvKf+8uDDUCZEP19oKUEx6YesREPFV9X8R1OYqnTSPwkM3a
	 PKW1BEcgFO38z/0zGfe1DI58IDzbMf9rFM2PWsS0=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 0/2] Re: Re: [lvc-project] [PATCH 2/2] [v4] wifi: brcmfmac: handle possible PCI irq handling errors
Date: Thu, 25 Jan 2024 15:07:27 +0300
Message-ID: <20240125120740.111330-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124133331.GA351271@bhelgaas>
References: <20240124133331.GA351271@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-sending v4 with spelling fixes as noticed by Bjorn.

Dmitry Antipov (2):
  wifi: brcmfmac: handle possible completion timeouts
  wifi: brcmfmac: handle possible PCI irq handling errors

 .../broadcom/brcm80211/brcmfmac/p2p.c         | 36 +++++++++++--------
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 20 +++++++----
 2 files changed, 35 insertions(+), 21 deletions(-)

-- 
2.43.0

