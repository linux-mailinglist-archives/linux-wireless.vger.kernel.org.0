Return-Path: <linux-wireless+bounces-15139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFDA9C1BA9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEF31F23D09
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325BB1E3DFC;
	Fri,  8 Nov 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rHLuJ/5/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634D194A5A
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063353; cv=none; b=ZbiJ1vJNLklMEet8E/MvumhMOhPVCjWie5W0+EBxtxYNY5VOX9wbVHKrRCs0AJVp04EiAgpS3JBCMfcusCYGmE/9IGbizQdGeaHsNafwpbhOS+6bN8M4gBlhp+r04kiejbxXiG10E776rUhfXzlfY0kIUy86RBIKmlLzZ4hkqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063353; c=relaxed/simple;
	bh=TjpcRJnXnupaEj6XkDqk0tJpCwagFOqJS+9z8z0pstI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmXWUuaL93yp071nTueXOEpI/Ha/Htr65LLbjWtLfv+hrGAWSdCjTexqKrRBPaH5sd2GOUb/okJ6O8JoFymLDPIKeOacE8V2bNIT3dKczuSISO1iEfr4x7IX1sbY2MuCNJUdMFZwx/JU6jezTIIjz3wrXjE/lqhl+9LLxrK0hHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rHLuJ/5/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h9ikxAsbyIBbD1iLAnPTHixhFzKCFzX/+PioBnDpPa8=; b=rHLuJ/5/vcxNXddzrzSNenuYzz
	uxnasRju0ajiTk4XV1zE34Uc04ntJdg/xXdPVhg8eMfn1nfuEK8/BP57k8yoRwxEGqsljErDvGKy0
	2K7eJ0r5tt2E+Uu5KW5TAPmy+GSKxePwvY56uLo5uG8IqrwA308bLWvUoLKeOpYlf8NQ7MAk4z8MK
	qq3PWliffa2fU4s+akpOOdTssVNQy0hkzrs67XlNgeVEKOZCmzNDImx/RiVySwrOgX+0+ts+eF2gl
	of6KeUhLyzImnOGK71DvnU8dtmPGfcg/rn/JDPDTMoBqhKccTLDT6jtCOppr4sac2NL0hsEB5wcvw
	U11MfpBw==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t9MeX-004028-8q; Fri, 08 Nov 2024 11:55:45 +0100
Date: Fri, 8 Nov 2024 07:55:36 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH net 0/5] wifi: rtlwifi: usb probe error path fixes
Message-ID: <Zy3uKIzbZXluWcJ8@quatroqueijos.cascardo.eti.br>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <7f14133bbf0c4f2b8d7889e65c3ccf2a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f14133bbf0c4f2b8d7889e65c3ccf2a@realtek.com>

On Fri, Nov 08, 2024 at 01:41:45AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > These are fixes that affect mostly the usb probe error path. It fixes UAF
> > due to firmware loading touching freed memory by waiting for the load
> > completion before releasing that memory. It also fixes a couple of
> > identified memory leaks.
> 
> This goes via wireless tree, not net. Just send to linux-wireless (you have done).
> No need "net" in patch subject. 
> 
> I would quickly check if you did really encounter problems and
> have tested this patchset with real hardware?
> 
> 

Yeah, I was playing it safe here, in case some of the same rules apply, and
"PATCH net" was required.

If found this with a reproducer emulating a usb gadget device (by using
/dev/raw-gadget), and then injecting memory allocation failures at
different points in the probe path (at ieee80211_register_hw and then at
init_sw_vars).

I haven't tested this with real hardware, but given this lies in the probe
error path, I suppose it would be harder to test for the bugs that they
fix. On the other hand, it would be nice to at least confirm that it
doesn't break them, though I find it hard that it would.

Thanks.
Cascardo.

