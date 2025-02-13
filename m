Return-Path: <linux-wireless+bounces-18916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DABA33F32
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 13:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A468F188DA13
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B8221563;
	Thu, 13 Feb 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d24A3bXY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B630227E90;
	Thu, 13 Feb 2025 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449971; cv=none; b=V36CmmYQyoKel2TGC4QlSIUPaB/RC5379B9hlI6hEJr8hQF3Zx5nWOD07tfktGxPM+Dr8evH7N6369zl/i/4lB2VPFqTV5tDThhjeeVY3MabEmyU3aFmJIuWeqpzL5AVTaoKfOskG415H6RnNGyhn220bjBKzhEKsGdR7uHxdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449971; c=relaxed/simple;
	bh=sn1SLvecqX8MO7WGjJQkV0eiE0Motsd25pos6RLnjx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAAwfHcuaFfOdaHItXbCKIFasA42XaitkCvb+0iNjJPeEldnq2hywv35F4c01qu82Ex3IRP5d7eR8ARyREVQO/x1mZa92NfZ9dfp9oONg1i0RqvuIiITFiIA57LplpFSAQCBB4e2zZ1PHKEeV5yoM/NzaNW5Sd30RQ64ODjZ2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d24A3bXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500D3C4CED1;
	Thu, 13 Feb 2025 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739449970;
	bh=sn1SLvecqX8MO7WGjJQkV0eiE0Motsd25pos6RLnjx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d24A3bXY0UPIRYlU8FBwb8rchcmeXDroZrvXeG9oaqnRyi1GgIHRE+jroxL8a2VMR
	 hTAOpioOa1CSHUY0deqnm9Ocspn1wxXKuaI4XuFUmpZxFRTg2iSwVfIr1IXBwAuhPG
	 4Y+W5CUae0oDdescyVGTKdtsFEhj166YM/M6ZdOo=
Date: Thu, 13 Feb 2025 13:32:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zenm Chen <zenmchen@gmail.com>
Cc: linux-wireless@vger.kernel.org, pkshih@realtek.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v6.12] wifi: rtw89: pci: disable PCIE wake bit when PCIE
 deinit
Message-ID: <2025021330-squatting-routing-4279@gregkh>
References: <2025021143-neurosis-snout-c9b3@gregkh>
 <20250211163409.1177-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211163409.1177-1-zenmchen@gmail.com>

On Wed, Feb 12, 2025 at 12:34:09AM +0800, Zenm Chen wrote:
> > It also needs to go to 6.13.y too, right?  Please provide backports for
> > both as we can not take them only for older kernels as you would have a
> > regression when upgrading.
> 
> Hi Greg,
> 
> Thanks for reminding! The patch for kernel 6.13 is here:
> https://lore.kernel.org/stable/20250211130432.1091-1-zenmchen@gmail.com/T/#u
> 
> Tested with RTL8852BE on Arch Linux (kernel version: 6.13.2-arch1-1)
> and it did fix the issue.

Ok, thanks, but can you now resend the 6.12.y version?

greg k-h

