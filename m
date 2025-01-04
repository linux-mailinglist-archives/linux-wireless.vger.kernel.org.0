Return-Path: <linux-wireless+bounces-17066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50DA01401
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 11:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CA73A23A7
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717117BA3;
	Sat,  4 Jan 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="xf/cBcmU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49818A6AE
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jan 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735987085; cv=none; b=PGCO+5fBq8YNDp4O6KTkduh/Lq2I2ltn8UFP/1C+P2+bD4hRctwu2bq+UWIzsR4kl7pzjDiE+/uStOKgqY2VOPF9OtWaQo4AYZrS569DaQkWta8aa00Rh/eT6OQmUZNHa8Z384pFSMh+DflqKzlwndMhwqJ8auAh0V8jazXq2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735987085; c=relaxed/simple;
	bh=j99Hy9f/m/6H2ncMt2PkmqzVoiQQd4NCimgrV8e/PBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrjvBE2jI633+5QURDe5fwoz90/Y4TynkdgZxXucMq7zM+UTDpbbudCfByBe0je3pKAYXaIx3JBovqhbQUwZApFPr3ePTKdoGe1ubWrHQ/izn9vFMakKYhFROlR9LznS+3RUpQpcX0diJRZwANrmPYLwx0P8FZQlJXlbDvVCTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=xf/cBcmU; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 9043 invoked from network); 4 Jan 2025 11:37:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1735987074; bh=qeXFkM/Z+0bLLnbriu+sMFeZVgPmL4DAuWtHihsWRo8=;
          h=From:To:Cc:Subject;
          b=xf/cBcmUERlkfMY8kF59exPSp6p4kxCBryrl9n19y/nl3byAAsQMh3xRJM2uJCgsR
           HREvW9fRraN6gSchMLobc6G+PHDd+/QlGq/0RRyC3JHGgmhwBvahQXrXUao1lg3hRL
           GiGTs2k9+3ZDwfzx5V9W0ZPiLIUJUcsPCQLM9PIvX2bW3iaFlCdhsX1z5azlVkxMym
           G5VNSc2++fJtat2ROBpHZifZAdi+r1LKz1W46jvLTT+8p8KYC8xvkqROGsz/wj+H+N
           90uLJrqKxHTMUcl+tsv5jI/L6nrR7ZuL3cbv0Kn98DHzOJdgL4EF6ZzKjJ3i2AJCHg
           k+mNeSJryH8+g==
Received: from host-178.215.207.194-internet.zabrze.debacom.pl (HELO localhost) (stf_xl@wp.pl@[178.215.207.194])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <Ariel.Otilibili-Anieli@eurecom.fr>; 4 Jan 2025 11:37:54 +0100
Date: Sat, 4 Jan 2025 11:37:53 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: Daniel Golle <daniel@makrotopia.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
Message-ID: <20250104103753.GA2228@wp.pl>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
 <20250103131002.GA100011@wp.pl>
 <2f7a83-6777e880-a451-5cf12280@99910178>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7a83-6777e880-a451-5cf12280@99910178>
X-WP-MailID: 0dd64d0715a5a75b870d14f33d310231
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EWME]                               

Hi

On Fri, Jan 03, 2025 at 02:39:21PM +0100, Ariel Otilibili-Anieli wrote:
> On Friday, January 03, 2025 14:10 CET, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> 
> > On Fri, Jan 03, 2025 at 11:40:52AM +0000, Daniel Golle wrote:
> > > On Fri, Jan 03, 2025 at 09:55:40AM +0100, Stanislaw Gruszka wrote:
> > > 
> > > I agree with the likely intention here, however, the vendor driver
> > > also comes with the dead code, see
> > > https://github.com/lixuande/rt2860v2/blob/master/files/rt2860v2/common/cmm_rf_cal.c#L2690
> > > 
> > > So this is certainly a bug in the vendor driver as well which got ported
> > > bug-by-bug to rt2x00... Not sure what is the best thing to do in this
> > > case.
> > 
> > As this was already tested and match vendor driver I would prefer
> > not to change behavior even if it looks suspicious.
> 
> Thanks for having looked into this; I much appreciate your feedback.
> 
> From what you two said, I understand that the patch should remove the duplicate code, and not change the logic behind.
> 
> Is this right?

Yes. 

Regards
Stanislaw
> 
> If so; then, I have nothing else to do.
> > 
> > Regards
> > Stanislaw
> >
> 

