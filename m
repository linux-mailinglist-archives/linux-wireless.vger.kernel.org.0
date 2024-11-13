Return-Path: <linux-wireless+bounces-15268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D79C748A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 15:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B822824B2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064FD273F9;
	Wed, 13 Nov 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="rTfRFRZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F64C6C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508692; cv=none; b=QjSqRawXG9X+dfjxh1NLa+zlvwH+I8OjOpKyUAv74ndMoIo0Ng8cd3j2xVlu6cHYI7/vKV7UJWHaMErGUEhxec48VLHwSsJ8ZBJui6lE5kD/Jdo70cPVhS77+Wz2JRmuVpSuWB2CU9DWnWR6MKlJjRCA4WDDWRjPyKUOU5F8Fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508692; c=relaxed/simple;
	bh=KNiFVYX8+Z7XkNZywPQUEv4OGYtfcW2ar/hIm1xjh4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkfA9rIVG+hgHMSehuXz5bf3leV8v8kt/pmjE+i4ejiAes5cptDKUo0JzwHTLWtlIkarQ1VgpwdEKundr6JIwgbRjriHDYA+ELV5c87xGtXe7tXqZtkRhAgyGQeR5rvXC0EMxzQ1RjrvwlPuRmruMcqzr61HMbwG+lBcisd5eQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=rTfRFRZD; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0CD54280071;
	Wed, 13 Nov 2024 14:38:01 +0000 (UTC)
Received: from [192.168.101.118] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A9B9113C2B0;
	Wed, 13 Nov 2024 06:38:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A9B9113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731508680;
	bh=KNiFVYX8+Z7XkNZywPQUEv4OGYtfcW2ar/hIm1xjh4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rTfRFRZDlSOjbDIqS1zh0Q2g6f7Bi4tBFTcTmbm+AWzWnuzn6EUpfWPeZkVG672d1
	 vNQDOlwcZ8RmIWCHQ5GMtedos3pQtC34aLFP++0QW9EVpuAqYXFQGSQ7DdRMS6GIfC
	 uOLDuYkKc+Jk+QTS9fqbQBvEkH2ywI4UXBh1sqDE=
Message-ID: <506f9687-6d13-4abf-9690-b7d738ad182e@candelatech.com>
Date: Wed, 13 Nov 2024 06:38:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ethtool: add monitor channel reporting
To: Kalle Valo <kvalo@kernel.org>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <20241112211422.331928-1-dylan.eskew@candelatech.com>
 <877c97w6f2.fsf@kernel.org>
Content-Language: en-US
From: "Dylan E." <dylan.eskew@candelatech.com>
In-Reply-To: <877c97w6f2.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1731508683-SVinumc14fGG
X-MDID-O:
 us5;ut7;1731508683;SVinumc14fGG;<dylan.eskew@candelatech.com>;9989741adba0574bb335b9e9d00002fb
X-PPE-TRUSTED: V=1;DIR=OUT;

> I think the subject should have mac80211, something like:
>
> wifi: mac80211: ethtool: ...

Nod, understood.

-- Dylan


