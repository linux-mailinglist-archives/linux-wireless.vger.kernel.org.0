Return-Path: <linux-wireless+bounces-24187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD36ADC54C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29053189451C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4828C036;
	Tue, 17 Jun 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXmPsthd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C423B601;
	Tue, 17 Jun 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150007; cv=none; b=q6EHs57lGeyDUc689RuEeNWiL5Bya7QqertaK08dsoG3jNAQEbWSfAualBy4ib0vszsCIuiC6GL//UXwdL03RW4+RMvRNmim8RtSUCELFyFEXwvmuYvZKauWeVa32wGvlJhNbwNlO8OMg+fQuOm+NCN00Mv2Hc9Y/4iFm8TcMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150007; c=relaxed/simple;
	bh=UOC+kxOE3OLiMAYZQ8H+yk57DcCQ6dMktSpb1jyC+6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S486Z+4+w7BLS2XE2ngMf0BoyaieGjiI5Vxv6MafLkf8CUGMBK+kwPt1kGy0PCCg5FoVvSiwhn5SfhQcQ7AuxjWU8RIMhY/DeW8nkPJteFMa7PYvZSb457T5QlxvoIFJlLdzKfAIu3r5LYrM8MnyjL+iTsI1gKj4K6vsHAcgAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXmPsthd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CBBC4CEE3;
	Tue, 17 Jun 2025 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750150007;
	bh=UOC+kxOE3OLiMAYZQ8H+yk57DcCQ6dMktSpb1jyC+6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXmPsthdJOuimlL4S/oQli4WOuXI41v/dyqIfStlaJikD3cjHFQNJ9QJpwfoD76gl
	 TItbD3NTfoq4+GgKg1wTFekzpYALQb+GNBiXwThN32ghyR3zGQBwPDD4YePHNNpOqL
	 fdi+tx0QysjjARUkFKCoD2amPfQ7ldaGbHJJM3tOeZjvwKs06QrpPtqWV/RAPZyYgr
	 wtseBup9QqemwmilqI9W63RIEk5GpxWAr9lcWv8uteeT/Y4kv+4tJsvHTOFmHsxVaC
	 g8M7YKSPof+JYC2CgL7kAdOyGdS5aRzZivIn9HZ2IgbjKE0dRGE8aWXFKNSfIEX8hA
	 gm8qc8Kn1FwBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRRxt-000000003p7-16ok;
	Tue, 17 Jun 2025 10:46:45 +0200
Date: Tue, 17 Jun 2025 10:46:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Praneesh P <praneesh.p@oss.qualcomm.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	P Praneesh <quic_ppranees@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
Message-ID: <aFErdeZlT-Hm63pu@hovoldconsulting.com>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-2-johan+linaro@kernel.org>
 <6f3eb9fa-617e-4434-8fc4-33dd92c4bdd2@quicinc.com>
 <aEFqsghEuJc3xxlU@hovoldconsulting.com>
 <ed06d62a-4b98-443a-a2ed-c92058bb521a@quicinc.com>
 <63c2c889-0a09-4b25-a1d2-2aaa92d75d9f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63c2c889-0a09-4b25-a1d2-2aaa92d75d9f@oss.qualcomm.com>

On Mon, Jun 16, 2025 at 02:59:24PM +0530, Praneesh P wrote:
> On 6/5/2025 4:19 PM, Baochen Qiang wrote:
> > On 6/5/2025 6:00 PM, Johan Hovold wrote:
> >> On Thu, Jun 05, 2025 at 04:41:32PM +0800, Baochen Qiang wrote:
> >>> On 6/4/2025 10:45 PM, Johan Hovold wrote:

> >>>> Add the missing memory barrier to make sure that destination ring
> >>>> descriptors are read after the head pointers to avoid using stale data
> >>>> on weakly ordered architectures like aarch64.
> >>>>
> >>>> The barrier is added to the ath12k_hal_srng_access_begin() helper for
> >>>> symmetry with follow-on fixes for source ring buffer corruption which
> >>>> will add barriers to ath12k_hal_srng_access_end().
> >>>>
> >>>> Note that this may fix the empty descriptor issue recently worked around
> >>>> by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
> >>>> monitor ring").

> >>> why? I would expect drunk cookies are valid in case of HAL_MON_DEST_INFO0_EMPTY_DESC,
> >>> rather than anything caused by reordering.

> >> Based on a quick look it seemed like this could possibly fall in the
> >> same category as some of the other workarounds I've spotted while
> >> looking into these ordering issues (e.g. f9fff67d2d7c ("wifi: ath11k:
> >> Fix SKB corruption in REO destination ring")).
> >>
> >> If you say this one is clearly unrelated, I'll drop the comment.

> > Praneesh, could you comment here since you made that change?

> Empty/Drop descriptor is intentionally issued by the hardware during 
> backpressure scenario
> and is unrelated to the issue discussed in this patch series.

Thanks for confirming. I've dropped this comment in v3:

	https://lore.kernel.org/lkml/20250617084402.14475-1-johan+linaro@kernel.org/

Johan

