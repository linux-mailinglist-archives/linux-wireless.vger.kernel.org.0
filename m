Return-Path: <linux-wireless+bounces-26207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FEB1DBFA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6925F16B107
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224A271478;
	Thu,  7 Aug 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNik9z27"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15C26B777;
	Thu,  7 Aug 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585458; cv=none; b=YLJeIQ0mXbRQOth+mTLvqpgTdggEzU4drLfLG+GrlpeG4F8XyJVWp84dnxS+pD+jYgeonps6CpxgF+KOWo/01gpqUGkgZTFHFJ7Tmgw+vfyFG5iuO3aZ4tCBNRIDKRmPn4jSbzwQwm5cegEB7DsvSyp5KSi2mArgf6VIPiV1ImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585458; c=relaxed/simple;
	bh=ZCdy8wrGaS31m/vyICQ0sTRH47wx7RDv45XHLSPATl8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJiWBUenQYKAxS92EUmfmfjA7sXUDiEzh1Gpmp9y8Xqt0TvRfka3xMfPQPKbiG50XoFKDZrYidX2X1ssHxIRmxLl7BrLOlhop9sdvZAZS0KSUkvjizUf/aR7eeMCAptg1c3vo1nfcYgwQxDP7OAHVsPYWd3l/VnC9qvarxchJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNik9z27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03939C4CEEB;
	Thu,  7 Aug 2025 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754585457;
	bh=ZCdy8wrGaS31m/vyICQ0sTRH47wx7RDv45XHLSPATl8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=qNik9z27Gusn8Dk1XqpuixFITS1eF8nfsD0OLtmIPFNYe8ipK9j1zenCckHJewAyM
	 iO45DVl+9CJrbLfDQxwixJ+ih9YbPa7rGjcdQltbZVhAgHvCMnEE+jtzDK/D/xZDL6
	 XoVIemImM3IpQMChEHWkSCVIEEnNHKhu/xsfoqbWUO69SuQQwBfSdKH8R/3bp0iYWx
	 f6r7qWaYqYY4JGlcRlDa6C0j77xWgFxE0ptgcU+nBvut0XvZ3J1A52VIDzU0SXS5bB
	 VnSBaN8zI5C/Rz5qp+/4SpLU7X3QJFi9LuEPl/g1Rqyp6ZPN92hCyZ6cdhr1JgVqdG
	 d9jRG0oTobIPw==
Date: Thu, 7 Aug 2025 09:50:52 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] soc: qcom: mdt_loader: Remove pas id parameter
Message-ID: <vvo63eeg7q37qrgcpsiw5a6dl4ffa4usrr6lqozwyqknyz23ny@g4m7oeeudvby>
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
 <20250806172531.1865088-3-mukesh.ojha@oss.qualcomm.com>
 <c9d761a2-7121-4ce6-84c7-232a6c4ce976@oss.qualcomm.com>
 <20250807053610.siel2gsvl2igc3ga@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807053610.siel2gsvl2igc3ga@hu-mojha-hyd.qualcomm.com>

On Thu, Aug 07, 2025 at 11:06:10AM +0530, Mukesh Ojha wrote:
> On Wed, Aug 06, 2025 at 12:07:05PM -0700, Jeff Johnson wrote:
> > On 8/6/2025 10:25 AM, Mukesh Ojha wrote:
> > > pas id is not used in qcom_mdt_load_no_init() and it should not
> > > be used as it is non-PAS specific function and has no relation
> > > to PAS specific mechanism.
> > ...> @@ -353,7 +353,7 @@ static int __qcom_mdt_load(struct device *dev, const
> > struct firmware *fw,
> > >  	if (!mdt_header_valid(fw))
> > >  		return -EINVAL;
> > >  
> > > -	is_split = qcom_mdt_bins_are_split(fw, fw_name);
> > > +	is_split = qcom_mdt_bins_are_split(fw);
> > 
> > this should be in the 4/4 patch
> > 
> 
> Rush to send patches!!
> 

Please don't!

Also remember that this isn't a regression fix and we're in the merge
window, so we're not going to pick these changes this week anyways.

Regards,
Bjorn

> -- 
> -Mukesh

