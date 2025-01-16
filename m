Return-Path: <linux-wireless+bounces-17605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D69A13B33
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54941610D5
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87E22A819;
	Thu, 16 Jan 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1A04JlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529122B597
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035494; cv=none; b=fAvzY1kTgyItkir4qoF6NvdHv+V7Lg8H/HAYwEY+tTf3MP2b82pg4xltwBZlWkhW+prL6RWzcm7hQii+p/UDt6ACOnHDPdx7miRrswdX1vU1SVQ5C3Cw9N9e9krTbNSnL8ekJ2BkndMbGf0STVKNkHYK40lbqo+OlDhkZsE4uek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035494; c=relaxed/simple;
	bh=KvGwGbLOboTQnmoegkqNqUjKynNMZPV9YcHg47pSi1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TI3TiZVp8I0upK4O4X4C/l+FNO2LlV6HwZeLWFsHVNkMI1M4NO72J1lFqZyU3aPKwUyzn2YJPok6y2BDTmn3fxqoCPpmzVz02/YtSdqr9G+kdtt6dr3LjS7ubmtOzo/NtJzJB3QwHPN/NzszvN5kcLlOcwYt2sPc/7fq0xlU8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1A04JlG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso547941f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737035489; x=1737640289; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvGwGbLOboTQnmoegkqNqUjKynNMZPV9YcHg47pSi1s=;
        b=D1A04JlGwoq5WKNTFj2lNnTB1mOHXLg2OhWq+uvZIypzwMEIUba1bc56/y7MZ0kLJs
         q7seMt4pV/NJFSYlhdz5ogVBYu146l6gvHFUX8A0E8Ku6CbJwR0wMgcqvuwXa72Zpmmy
         4BbRZ/aQrzQWWVY3OfV5UqWn4RmmCdjGNFcSgCIFLoou0XKmM6vTGHrD2jtmfkdEi5DE
         MqHaLMa8JS4NzcxXHQWfbNb2IcZeXQuzLxZnNM1wb6feFiivwOUnyGLRK8xLisK6TDwA
         0AiBC+r/q99WOr2BKEMhTHwwSUrr4MrhalM83lK+chWug+eK393bmcfolY4cUNn0SFDk
         n5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035489; x=1737640289;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KvGwGbLOboTQnmoegkqNqUjKynNMZPV9YcHg47pSi1s=;
        b=RJeGokFynwG1E34k4705olbQq/risbqtS1g2pOp6iCCOcBhOZS9bVTbOtWlCCsO1Ms
         V7eXeaf4CKvtMN174Dfo+VqGpNGD5ugFBa9NoZHk7xJZ0Tr3WUIOfFvRq1qqPbZwN6O6
         II/3/OdcyY742K57nrC2b5yXuBQtW+h5iGxmAJJt14u2B/Gz+V8Po0i2Yc75eet7D0r6
         4V2ES9sQD2nvVo5XOxN/vLYWSkZWDEtjPW347JXiv54X+5Dq4cL9kjmlTnXAcbPozMv2
         5CMBjMwNhS2r+FyDQKrUpRpQMdeU3XzaB2Rwcm1cheuSV8J0j9zkmpaE8/GzxKVlDkGj
         FCdg==
X-Gm-Message-State: AOJu0YzIxmF6Fbjb0BoKUTDKr3cprZJQN37P/fLmWMSBBMdwbmnWLiHy
	z+Eb9qLs7ZkNs0jeNZF/MG0EOXl4nsTgNT7WwRdPss2c+aqKpqYy
X-Gm-Gg: ASbGncuI0sY9I23WTN3ecaRrTzi5sz6CFO2AJde5TM1OSnz45ghr4xbCDGnVYpL02KJ
	+Xh3ScgAiYUyLiLjKjmm7uUT42P7c+wEibdr0zG+xIcc9yppCOq8Qc/iGeX6nl727mxmAUH1LhT
	kZefObbA8lfHC0anGcpImfKnZsNm+RMckHrQ5vt1xQzP0n2GdXi9mPeFQxM8HYlKxVKKe6D6Hzz
	cjQpfADnq1wuDPE+R+S5r9/ndQSlHhS5F0/3ofjFewarwmdiFbejqCUL/6x90bstKeo93BDREE=
X-Google-Smtp-Source: AGHT+IE/MbXNRZnW0uYuX0hY5+W4YuEcxxEbHhzAQ+N2/2rO7RBd72sJSqF2b+UdU2jLH45twuYLIg==
X-Received: by 2002:a05:6000:144b:b0:385:f13c:570f with SMTP id ffacd0b85a97d-38a872ecc38mr32056664f8f.33.1737035489262;
        Thu, 16 Jan 2025 05:51:29 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38325esm20417723f8f.27.2025.01.16.05.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 05:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jan 2025 14:51:28 +0100
Message-Id: <D73JOV2O2F8N.1C65FLDKDSL2X@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/7] wifi: ath12k: Add monitor interface support on
 QCN9274
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Karthikeyan Periyasamy"
 <quic_periyasa@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
 <247ad29a-8c54-4046-8e75-8435c2addf75@oss.qualcomm.com>
In-Reply-To: <247ad29a-8c54-4046-8e75-8435c2addf75@oss.qualcomm.com>

On Wed Jan 15, 2025 at 8:56 PM CET, Jeff Johnson wrote:
> On 1/15/2025 9:55 AM, Nicolas Escande wrote:
> > This is on split-phy QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_S=
ILICONZ-1
>
> I don't know if it will help, but I just pushed out
>
> new firmware WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1:
> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/a289=
ab4de56345be86d2c89c81aa12577c2c5a30
>
> new board file:
> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/bd2c=
a865d78f3d7d899e06cef57e5bbb9da60bf7

Thanks for the tip, I just tried it but alas it doesn't change a thing.
RSSI (and maybe rx/tx bitrates not so sure) is still broken for all connect=
ed
STA after a monitor device goes up & down.=20

