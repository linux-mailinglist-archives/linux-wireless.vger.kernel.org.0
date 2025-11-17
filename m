Return-Path: <linux-wireless+bounces-29059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DABC65BEC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 19:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D02C353609
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2525B314B9A;
	Mon, 17 Nov 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R8ZCONOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C61314A8D;
	Mon, 17 Nov 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404736; cv=none; b=eiDsoLWL0KadqGB+ybFsEVrguYu0G7tcf8AZlofidyS9nUJ8PehrhbW0s3yqUcQp7qmi1AeW2GCUPHt50Q9hExAvm+0ZtXUmxkKX2kMnI28TTBVmmyGrvgBV8L4MDDNEuk5dwFOWlcZe8B0Wu2uvlE94eoN5u5z691RHLnCw9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404736; c=relaxed/simple;
	bh=lx8eiW5bhr9Hf+rhZP+EsGQ6t7eRjYA+oarSv1YskmU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LbypNaSZ9T6UQhBVu9Slt+BYaX/SqPOka4bceKifyvGg7xHz55rqPHssXrKb2vbfkSBgDaPgcwtlM67t63UWW+6sCrM83cfpWPeMp7tBSG9PH6nkg/lqs4gvg63DRv6XuDMmeZrn0JBCuDNKIt8bF0gCM+E/zVk51/jV2iRCzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R8ZCONOF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763404730; x=1764009530; i=markus.elfring@web.de;
	bh=lx8eiW5bhr9Hf+rhZP+EsGQ6t7eRjYA+oarSv1YskmU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R8ZCONOF0qDTsfGX05IBuRh9FIcYK1yDJyQlzaA9uJ/zkp4v40N9nCJBBWRAeWf2
	 2V2wU92bSl1HCou0Etpbb2e4grIJB+oOA8Ear+XWXgE3VJielzFKl9AvUBX83Rus2
	 kyYEtj0MpXbmFr+ukvHNZJCbIhgO0STULcCXeE4PUAKiEGBiEDIpjnOtN2YrcY3Dd
	 QUMJ5kIoApqUyI8EeGiJ91VOKDKUP1O+7sdVBykPTUP5gkldxKUilYAJ6L7GPtQbe
	 CTC+3xE7GemgTB1vzcy94uZodlQGLIEDshMa7TmzYu+gF1mPC4+GqH5wa4wUoxX85
	 VQDjO2qPQy+tTI9aXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1vkX5V34h1-00TKU1; Mon, 17
 Nov 2025 19:38:50 +0100
Message-ID: <5b954790-e7ed-40bf-b8a1-136bf6c99f98@web.de>
Date: Mon, 17 Nov 2025 19:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seungjin Bae <eeodqql09@gmail.com>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Hin-Tak Leung <hintak.leung@gmail.com>,
 Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>
References: <20251117180955.1710801-2-eeodqql09@gmail.com>
Subject: Re: [PATCH v2] rtl8187: Fix potential buffer underflow in
 rtl8187_rx_cb()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251117180955.1710801-2-eeodqql09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xw1fX5EDL1Lyxh1TrEk9huC/rionrDxLULyLx7+3YA6jO3azJAO
 cHzMUSO3VVBdP1TG8B0M6Pkqt7jKj/qgAUlUBP8FYO4spIGXhIpP9uVhCwb6skuO0LWZ/ro
 OUjT+gZ2BIPHcqfJaG1SZpTT4AzNGmwk8Fh1/vay6pIGSveckZIWUTcISAYlk0vhWBMxS5Q
 s0/ETo1yjmk2N3kScMAcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d3bt44UdNTE=;Yg+j/Kj4Dk55tN3WNxMP+6ozWMr
 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
 hDevnIRmoPLuG3sMM=

=E2=80=A6
> This patch adds length checks for =E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc5#n94

Regards,
Markus

