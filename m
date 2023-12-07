Return-Path: <linux-wireless+bounces-543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C0808952
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEFA1C209EA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF640BEA;
	Thu,  7 Dec 2023 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="houRMNEI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33E405DD
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 13:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8EC433C8;
	Thu,  7 Dec 2023 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701956252;
	bh=oCmGs8e7SpjRy+Vd5XKtyFu88CTeYgJP7xGauoAW/Zs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=houRMNEIKs5cps4+ut1rJB6U6ivq4OYj4xgU5uMkj3D172jurecKVSCsnop3dPe9k
	 U1d5J0WTypOBy0mJsBPHkgTzDou4XdkrxEPFJhxqSVBqcsCnzFpTWBC3ckxc/ohIFf
	 bc+BKuc/PmLSE+E3dGpcOm/UKakpZFc2PNUv7QqxDf47q3lcS0wbBMs7CZjNpS39b1
	 cAVr1z01JphowU1OpdW44MaAaSKWhl/ZdrYATRDEoh5iELzpVv7Pv4ZJ8VB76asH8K
	 BCPwNmqd85v3Klogh8iIZuSOWomr7ZUYonIRCGwlOMVi70dRBCqkPBExMgPVwaRLny
	 tmBnBC7iSl5tA==
From: Kalle Valo <kvalo@kernel.org>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Johannes
 Berg <johannes.berg@intel.com>,  Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 13/13] iwlwifi: pcie: add another missing bh-disable for
 rxq->lock
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
	<20231207044813.acb50fabb4cc.I8f19713c4383707f8be7fc20ff5cc1ecf12429bb@changeid>
Date: Thu, 07 Dec 2023 15:37:29 +0200
In-Reply-To: <20231207044813.acb50fabb4cc.I8f19713c4383707f8be7fc20ff5cc1ecf12429bb@changeid>
	(Miri@web.codeaurora.org's message of "Thu, 7 Dec 2023 04:50:18
	+0200")
Message-ID: <87h6ku5e1y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

miriam.rachel.korenblit@intel.com writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Evidently I had only looked at all the ones in rx.c, and missed this.
> Add bh-disable to this use of the rxq->lock as well.
>
> Fixes: 25edc8f259c7 ("iwlwifi: pcie: properly implement NAPI")
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

"wifi:" prefix missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

