Return-Path: <linux-wireless+bounces-20616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051AA6A61E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 13:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B1E1883851
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9922171F;
	Thu, 20 Mar 2025 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="tfwbS/SH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B265221579
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473072; cv=none; b=tZ15Hd8GG4om/OVeS5n/SxV55Ek/Nt3I2a6o6tNnStkXTZcW92HJqlY3L+AKEtSy984LHinKMDpFQcliDKcNC+oH0gYBL7uCOBWDdqdXPS1rDz8sfuRbQCnvOUWX+W3KqesUiVBoryNtAEBwHciMtEt3M7EYOb0TN29f7i8gTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473072; c=relaxed/simple;
	bh=NeL9K1+yzlJrt3Rxv4bLGKJY47lqocCq4fqdq8nBktk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6AyZ3ieW2+ZbYVcKwwIA+zK25egigPAcS3Y1n7101uAWxiHCE/GSV9eEywn08aQmADwo/JyViwtLURdN99MZLf2w6eSysfWQ21y4IsGO/esjnCzC/lzu2Q40AfbUqFMJN4rEkrguchavNzsjx8G4qlBJXTp4QkmoR05BPuysHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=tfwbS/SH; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 8343C2FC0191;
	Thu, 20 Mar 2025 13:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1742473061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2G45JwkiuKUFcys+DtoNHHLBH1XV9DqRJlWo0d+5yw=;
	b=tfwbS/SHdB3Tn/U0To+HdM0bzbrExuU4nUwD3hoB0q7SeSg+1Gpvnrt6yeGhotAQN5v7Gr
	IRgmu31aoWfAQOaSodqPwviIWpwhU4zoDCy6OHUee+xeeWDwCVZL+ADAsomLe3dS0dI/ig
	97GUuzj6PSL/2uMzDoUNNzh9sSWgCa0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <0ca4584f-7da1-4b0a-b526-75151625dea8@tuxedocomputers.com>
Date: Thu, 20 Mar 2025 13:17:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath12k: WCN7850 hw2.0: update board-2.bin
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: linux-firmware@kernel.org, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Christoffer Sandberg
 <cs@tuxedocomputers.com>, Werner Sembach <wse@tuxedocomputers.com>
References: <398de7cb-e455-4cb4-98e8-31471bb740a6@tuxedocomputers.com>
 <iffofcri7ah2pwu3b77z5zfsa2wkzl5mcoarm2any4fdcjvsys@o35roczyxb6q>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
In-Reply-To: <iffofcri7ah2pwu3b77z5zfsa2wkzl5mcoarm2any4fdcjvsys@o35roczyxb6q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dimitry.

Am 18.03.25 um 22:12 schrieb Dmitry Baryshkov:
[...]
> 
> Please follow the process specified at the kernel wiki [1]. Otherwise
> the next update by Jeff will revert your changes.
> 
> [1] https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html

Thank you for this hint. I will stick to this in v2.

Best regards,
Georg

