Return-Path: <linux-wireless+bounces-28135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0EBF66A3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449EF546F13
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C66355042;
	Tue, 21 Oct 2025 12:13:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6B355040
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048838; cv=none; b=tGSUZeHZmRGoGog41KYB4k5Iw19K4nbxHX9mgWf5rJ6o+vu/C/zpd12+ag4qYuewGkdvgcXbnhZDnfDrW4O0GReWvUCJgSNvboUXbPfPDprbJYwiP9TUKnfPk+VCGGFMu9I1VTgBRjFW9wco+v4C8xQyj7UO/URT76ueZhLdPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048838; c=relaxed/simple;
	bh=YtyKfUhfLM4MpDIQOxxeD7bj63jeYTAjld20+NmljkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwF9qfGBztPpGp9OVruW/rGewdvpFxTU/hLT3rZI3WwpSogz6rAydE6fxhcvNUJOIBVMo5udxD8KgOs2xaUk88VIe+33p9ztionU1YXPr9bGIT4A2m5psK7wDaEW3zP66ZHUPAFVWP0DNpDT0Ca3I4R8HgCVRjXU/1PENpfHbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mathieu.digital; spf=fail smtp.mailfrom=mathieu.digital; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mathieu.digital
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mathieu.digital
X-Pm-Submission-Id: 4crWRQ60SHz1DDyQ
Date: Tue, 21 Oct 2025 14:13:37 +0200
From: Mathieu Chouquet-Stringer <me@mathieu.digital>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE
 operation in association response
Message-ID: <aPd48eufR6OY45__@nosurprises>
References: <20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
 <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>

On Mon, Oct 20, 2025 at 04:08:37PM +0200, Johannes Berg wrote:
> On Sun, 2025-10-19 at 11:52 +0300, Miri Korenblit wrote:
> > From: Ilan Peer <ilan.peer@intel.com>
> > 
> > Some APs, e.g., some versions of Aruba APs,
> 
> My understanding is that both Ruckus and Aruba have fixed these issues
> now (not sure how that'll roll out though), so I think we should
> probably not make this change at this point, unless we know that will be
> a significant number of APs that cannot get updated?

Well, do you have any idea when Aruba could have fixed that? I have an
AP-635 with firmware "8.13.1.0_93688 LSR" which is the latest for the
AOS 8 branch (released in September 2025) and it's clearly not fixed:

Oct 21 13:05:07 nosurprises kernel: wlp1s0: bad HE/EHT 6 GHz operation
Oct 21 13:05:07 nosurprises kernel: wlp1s0: AP 11:22:33:44:55:66 appears to change mode (expected HE, found legacy) in assoc response, disconnect

