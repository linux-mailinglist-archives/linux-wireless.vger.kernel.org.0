Return-Path: <linux-wireless+bounces-9463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3FC913804
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 07:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177621F226AF
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168FEEC4;
	Sun, 23 Jun 2024 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="bp8/VFG0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9D7FD
	for <linux-wireless@vger.kernel.org>; Sun, 23 Jun 2024 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719121648; cv=none; b=lunbNG2CawzaijNo3m1TGJmQGY0QcLsuTII7x1ady1t9CXjE77BJ/kOBvQNgp3QPFn5TVCfC3hKsDNOxhr1c2QEPcmPwUHHDxwVIfnrCqOleXqd8LtHh+8sgX2bfMtOY5IhSkpucN8cdcAyllv2ACMoczqiVoxgItXsg0ORGgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719121648; c=relaxed/simple;
	bh=rI5v0+s51me1ZsfM/5O1mxuiP6E0cbl1iXSeIv/tBxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spy363Ctbr+evTjtMJi+4+YIsOgwVqdNDnbxd3N8UlQWoYnqbKCuQuONG7jr76qZlcGHXxSA+i9nsNI90VkDwrNv5k0FwQy3ZUY7WBSCmSnAxCodYA/GeOwbWSkfdSdudlOUELYyF34h4flhNaQndvsUjQrOaafwbS0+qQUzw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=bp8/VFG0; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 504423FA80;
	Sun, 23 Jun 2024 07:47:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LE0iqBC6Ci5g; Sun, 23 Jun 2024 07:47:15 +0200 (CEST)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 257923FA6D;
	Sun, 23 Jun 2024 07:47:14 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 54FEB19B7AE3;
	Sun, 23 Jun 2024 07:47:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1719121629;
	bh=rI5v0+s51me1ZsfM/5O1mxuiP6E0cbl1iXSeIv/tBxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bp8/VFG0v7a6DCbDrNiwuXMtoHg1KwPlauP92VwzoPuoiuAw3f0cZW/PMEZ1WwSgM
	 wPsedLvIVBFUYg+LbGc+WyRLy93XUrAbDu0LC635etFru3ShP8/tfchw4ne9+sodaS
	 tSRYpaXBR9eLXnNuEMafX1NUzS57O9vXRZXzLgAQ=
Date: Sun, 23 Jun 2024 07:47:08 +0200
From: Sirius <sirius@trudheim.com>
To: Denise Finger <Dwanderer@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: Larry Finger
Message-ID: <ds6wc3svkyre4p2rwg4f76o67xndazaeoyjwblhuzichscyxoz@5ttdvbymxr55>
References: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net>
X-MailScanner-ID: 54FEB19B7AE3.A574F
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

On lör, 2024/06/22 at 18:01:23 GMT, Denise Finger wrote:
> This is to notify you that Larry Finger, one of your developers, passed
> away on June 21st.

Sincere condolences and our deepest sympathies for your loss.

-- 
Kind regards,

/S

