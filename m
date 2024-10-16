Return-Path: <linux-wireless+bounces-14073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917B9A08F7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5621C23BAF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0BF207A1A;
	Wed, 16 Oct 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpA/7PIm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D8207A03
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080113; cv=none; b=BI9S/x2pxG7VJQVMmupFnEWmhQ2f6wRxtjPMKz36ZwrpVAy6GnVH49PiUNl/bnAB6h7KukzvJ8LaTF4kXgCEyi2j6UDn6w2Mm+vFlrBAKLwgbpNBGrM5CGhlh9GvbobcOqysTA9BZpy2HOrsDH/ZGqrrzcBRMMRYqcicGs/vsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080113; c=relaxed/simple;
	bh=Q7LLV2w3gddlR/52p0111H0ukS2hKNuhILk9n0snq2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azun5GCJdz3etW5MnrCxPea9SWkPjf6pIDPxivixFMrBJND0HUBuXLqugz4UagsSQBHiLD5SyksERo/eAnby6Inyun8yrrDvhbPUszaPrfUBfiboMeF9pF4XPWGedqbFxX6rR7d6f0DETQRM5enveZG/RyTt5ubATNskjeLgD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpA/7PIm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729080111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0chUVeWVNXUa+6nJgceHk0TDRpnJb7xfMwzVuSrbvU=;
	b=cpA/7PImqHJ6s2LdeLB3I6FQDhPdS9Bh0XvK4JL49s6/QAQU6iFQTruZNMqf1qONb4/Yk8
	Y80M5UVakY7T9n1S3GX+D8eBn/QrqqrOAMapOVTbu/lH8Mu2ZW62BDqi4aBjx9VTfRb3ZB
	L2ZiVPz06vLb8rPAp5zHvtCvnNQ6fTk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-AtxIvyv1PyiGfnUaJkNNVQ-1; Wed,
 16 Oct 2024 08:01:48 -0400
X-MC-Unique: AtxIvyv1PyiGfnUaJkNNVQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69E86195609E;
	Wed, 16 Oct 2024 12:01:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92F9A3000198;
	Wed, 16 Oct 2024 12:01:42 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: ath12k: fix crash when unbinding
Date: Wed, 16 Oct 2024 14:01:38 +0200
Message-ID: <20241016120140.204902-1-jtornosm@redhat.com>
In-Reply-To: <039e7ccb-adb2-4c36-bd5b-83b5965373d7@quicinc.com>
References: <039e7ccb-adb2-4c36-bd5b-83b5965373d7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jeff,

> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")'
> #51: 
> Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>
> same comment applies to the 2/2 patch
Ok, I will fix it in a next version of the patches.

Thanks

Best regards
José Ignacio


