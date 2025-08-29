Return-Path: <linux-wireless+bounces-26849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F6B3B2A4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 07:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E07AEBA9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 05:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13FF137932;
	Fri, 29 Aug 2025 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="LAB9LUeV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C058EACE
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446284; cv=none; b=h4Nkhd17CRL1JcIz0AJ+tPRLUTwger+jZowVUe8qbxoDIN3qiuCwy+8ci/k/D1Yh1nFLwKLB3AIGCVPZ69dTR7tj5SQYAYBqKRSCthryvS9z7G0ZWvAZKtrEMSPXqAQsjPz2vqH6Fhrp8TTu14Mqd0i7/fmvJg9A8copGX3Z6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446284; c=relaxed/simple;
	bh=OAl5pGzAgL6AN2yPjuwCkQkquXAmKia6h0F+1FCZyxE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZXuC9GxzGz3C6fwvjnoWtZvsL6eToElfR/pCHXer8MRcHbdwrenaK78EjJM0eirZgjWMS/IOKiUuDKlyzUgfjLw+h7IqJJ9VCSFD6hD6rz1kdqbZJfNIrD+rMtrGFjkSESadTYNG92YlcbDCUWwbrtLpBKCWA4whuEScjf34BJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=LAB9LUeV; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=OAl5pGzAgL6AN2yPjuwCkQkquXAmKia6h0F+1FCZyxE=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1756446279; v=1; x=1756878279;
 b=LAB9LUeV8XH1lWn0vDVMZmfN7sCw9FRuNq7VN/2cQDCYueDprs76g6QeOn+OJt3Oskgu93eD
 l5fJB7s40RiPf+LVx1krTHTXOeZX1lwzN7Su+PDXiIphzHm+0VfCOqTDaYzn6MIlZo4BV+LTAr0
 UOQpFWJGjb4iCCNtfucoM9gzEotdnz64vBbkO98JON2pedd6EQMWwp2uh574mSxvfsSQPy51oa1
 Y+OG5hAQWGAoa8s9lxBObUYQkZg01oAOfV1BL+gkXXdqWpDEv08gR5G7ZUEhrP8d5i6yHfHH/uI
 1Pc7AOtiWH/ggX021MV55rxmkGFe8o6ndkauCfpqJgVwA==
Received: by wiki.archlinuxcn.org (envelope-sender
 <oldherl@archlinuxcn.org>) with ESMTPS id 44ba0e82; Fri, 29 Aug 2025
 13:44:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Aug 2025 15:44:39 +1000
From: oldherl@archlinuxcn.org
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: Possible Regression of RTL8852BE on linux-firmware-realtek
In-Reply-To: <c85ca611f0d74d2eb8bc400ebaaadb9b@realtek.com>
References: <2082485.tdWV9SEqCh@alphecca>
 <c85ca611f0d74d2eb8bc400ebaaadb9b@realtek.com>
Message-ID: <9ab95a57cffe13bcdfe6ad8b8027e41d@archlinuxcn.org>
X-Sender: oldherl@archlinuxcn.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-29 15:38, Ping-Ke Shih wrote:
> Did you use Bluetooth too? Please try 6.17-rc to see if it can improve.

I do have bluetooth enabled but at that moment no bluetooth devices
were connected to the laptop. I will try 6.17-rc later.

