Return-Path: <linux-wireless+bounces-24271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC2AE0933
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CCA1899C0B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83262253E4;
	Thu, 19 Jun 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K3psz1id"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAE267714
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344602; cv=none; b=jJFUB53dlOtknAy7n31HLSeJy61JTxV3U/CUPImy6zWpZR9JTvegvflCl1XEgeKVPK6V5R6tSQWqvfH20A3d8GCsdbMEREo5AhdjMVRuZIUQ9UYsfp4CvoUvOjstjYg+7m0YhQuVVUJ0CF4TpowIOeXKRzrZDsJl5LWEnrjIdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344602; c=relaxed/simple;
	bh=RmY0Xevw8TVnFstaNyUj2eJowpNdXKcRW6wC6tdkF2E=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QBjcrLaq4LLGIijsIGpDD1DIxa366mog7Te+9IbX/ryJNEUAVmL6fE2kZYzHXog5mTHClwnY4YyzELWPu1ciK8KubTK/jgrZHUBwvn7fKrTCv7sl1EjKjxUsldkOt8uKU50MsRizecSzWDSL4zBWu7xZe8YFhOodZpVXkJynIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K3psz1id; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e92cso528486b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750344600; x=1750949400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyLGIeI2pWRWGSJdrrn8FqSqrDl0tOwVhPMyUFPxpmE=;
        b=K3psz1idNX3kspWDOGvB0I4HG5Gwymsle511CdV00wSCotC7O3aDGY1n8D0h4A9DPk
         qTO76Hq1nFwh4Y7Dyy+nRrGDsZV/jn1xEjZgWAVMF59USMspyyh2bu3re7ynLBpNWdQD
         SUM8aeOWLmKDUefA9NMiTIWpsHPUrtS+SSnLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344600; x=1750949400;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyLGIeI2pWRWGSJdrrn8FqSqrDl0tOwVhPMyUFPxpmE=;
        b=D42lkwFuVY1UlnL7W3tqhQMVU6uNIQBLzjothe1UsaanfDHEiYGmY7HQwk45fRTo6C
         0A7Xy0Ldb/UX3dXK91MbVSJGdwBuO1rGLm6KJBQBZkZA+zWw0oBt9UwyDFRm4VX7qD71
         ORrHgrHaFf2yPmNmjEQkMa4XCPJAarcFcnpvro322yfeTAKsID/fYGxTh9yBxQuc4QcR
         9eRQSfl86UXACbC9NmeoVb5FVq4gU6bmtrw7G/7rXSQwYhldrl/wA+isx70/eeWMbt7J
         B5MAKzVMt0ItDxu1zc2+iUimIFEoPgjdjLuuo18hfHELfxWxN7n0ZWobY1FA7A1MxdYP
         gyLw==
X-Forwarded-Encrypted: i=1; AJvYcCXwM2XwyBg6cI2uN8hC1pYr7QqNvidV6EZXTzBpl9nMXfBINUgoJvhZxykqe3TLP4yvH+L/0IiXhaDXVKdIkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGS/LqyDCojIjCqVCepKNWXwdSYkB5/4StTcM3pJylQAnmevn
	YLWpsY42qDr9VYKxtyX8AFxbwPSpyCKY+ZJ6bWMKt/jZMXEdk+vppkCnQfJiQb+Ehg==
X-Gm-Gg: ASbGncv5/A4kstxn+GMJFQl/4V8l9XIpX1o+4xARhweiA7lGZCSQlqR0f/jAnlzZMI8
	4NSMBptyxT76rDOXlBhJIHEnqlfHdtOvMEzT04qhD83ZjzqMal/5F++a9k06HnGt9UZUJUxNwdF
	e0NFEiyO1AyhpN5eDgdp6zPVgJCI1vTyuivfB0/IP/N9dgb/rBEhyG1//9I2RJVep1tRL4Tlhb4
	y/ERwiRMDVAdK3Fs56Li8erBvIEzTqU+KM1V+bXWK68M6rKsnuTIU2ykio7uDb1+X0uGkmBXR2s
	vLGMpcSQtZ63RNMnAjaBAVkttpOLKiP6Kr3bjgDrHYoO4AZYpCTLRqgSJ4cNnc4ZK4NoUG1TGqr
	+0wy511LyGp5heAFDJ7sHe2HOpulwvzYygOw=
X-Google-Smtp-Source: AGHT+IE0IABp03aQi/MMdsx50TsZhfjlS77ZjBf2ZnkWRLyJkwYN80FXKFOnWqqtHBqMUe2X9qwO7Q==
X-Received: by 2002:a05:6a00:228b:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-748fb7cc2d2mr4770370b3a.24.1750344599760;
        Thu, 19 Jun 2025 07:49:59 -0700 (PDT)
Received: from [10.229.43.247] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46b569sm84792b3a.20.2025.06.19.07.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:49:59 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 19 Jun 2025 16:49:53 +0200
Message-ID: <19788aaee68.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250619082554.1834654-1-colin.i.king@gmail.com>
References: <20250619082554.1834654-1-colin.i.king@gmail.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [PATCH][next] wifi: brcmfmac: Make read-only array cfg_offset static const
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 19, 2025 10:26:15 AM Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only array cfg_offset on the stack at run time,
> instead make it static const.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> .../broadcom/brcm80211/brcmfmac/pcie.c        | 24 ++++++++++---------
> 1 file changed, 13 insertions(+), 11 deletions(-)



