Return-Path: <linux-wireless+bounces-14555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5F9B0DB5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260B61C21BB8
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 18:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A420EA4D;
	Fri, 25 Oct 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nmBa2APn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F720EA2D
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882085; cv=none; b=cBx2b2NHP2Boi3rKviD5Z+qzO3+lcgeoCuZ1Lsh8uDdvyqVQ5rB9+srijT/ISFUgmW+XKv9Nv+wk6Y7jpumPS+EklJsvBS4uBsRXGWTosuygWpIw4WrtZI4rrq4XpIcW+CJgoS71j2VJadDwSBlR/aqEWG+nqKujwtDaXTWNnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882085; c=relaxed/simple;
	bh=nf4PW4J7OPEp0bC9Zy7Ri1so7+xS2fBU+ifvzCD6UX0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=auhzY+TBCLJB9AsCxEMTfuJGN0ZWepLvZOL90Nrmr8/Z2gHzK3jGkOgF8QesBLPfXvOo8ESETDDyI6+Fjb3sQspMYlA1NsH/qfr1ZuQi2Hn7jV4HZ+ceVp/L0OIqrzxQI9wEBoRjE3IkXgRk4pe/Bx5PPidYiSPD5AzP0RI/AYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nmBa2APn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729882075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cgWzqfDff8Y3kbsrFgSK2EnKm7LN2kj3i4sVoqz1Qk=;
	b=nmBa2APndu0Slf6SLiJNT4oDtB54WHmIxeVMcPIIxRSJn2oDUMBkxJev5Gs0UpzxPHquaM
	4/pElesMoEuRHeob04d/2mKN5ekUoKPDP/UhlzvlnsoIqN0IruRqoN0zkgpiMYYKNlU2af
	N31I2Axo3j+tRCLweo0iqlO+B6EPoPQ=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] wifi: trace: Replace BOOL_TO_STR() with
 str_true_false()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <afe1839843d8d4dd38dd9368b2e30f0aa6864b9a.camel@sipsolutions.net>
Date: Fri, 25 Oct 2024 20:47:41 +0200
Cc: linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CFDD47E3-CFC4-4D74-8EE5-32D238C5B81A@linux.dev>
References: <20241025163210.1395-2-thorsten.blum@linux.dev>
 <afe1839843d8d4dd38dd9368b2e30f0aa6864b9a.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
X-Migadu-Flow: FLOW_OUT

On 25. Oct 2024, at 18:41, Johannes Berg wrote:
> On Fri, 2024-10-25 at 18:32 +0200, Thorsten Blum wrote:
>> Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
>> function and remove the macro.
> 
> That's an inline function, I don't think that works - you'd have to
> teach trace-cmd what it means?

I see - didn't think about that and only compile-tested it.

Thanks,
Thorsten

