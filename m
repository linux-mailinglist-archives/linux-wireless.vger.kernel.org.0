Return-Path: <linux-wireless+bounces-302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD0800EFE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C781C209D6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6C54BA85;
	Fri,  1 Dec 2023 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUeujLyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8FC8EA
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 16:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE27C433C8;
	Fri,  1 Dec 2023 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701446748;
	bh=nDl/aaAVTMBelGPOB6ViJvy/FJt4deD09PE/7R1bxFM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZUeujLybmuJFInTuwuYKDt2h3+Z1ytIBh3k9tNxmlPrxn23Jib8dZciNcHLQGn8HB
	 w/aoqL4LNzAefRd5ulTiq/uIcjkswukLtauHZcpEatm61msttJCkYNMRDHgJrU9TWi
	 UxTReEzxiNqaHpEou4zcXwcKAFh7rfLgJWh7C+MmHfIjo3MvGqlrOfk5yAdJy74wZU
	 oZsKaowZ0cFK/b4HXZJwEXSDucIu5uN7SZTgjXMTk9QSxyFVhPY/JD6qdpPVB9Ho4r
	 dbU2+rllrQMwnja4YwcDTv1MHrxjSKEPL3tKV61ri61pZDStaNVaq+uX6BPuAsMeot
	 cel/3dzgYWNqA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: Optimize the mac80211 hw data access
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231120235812.2602198-2-quic_periyasa@quicinc.com>
References: <20231120235812.2602198-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170144674601.2201420.17048744977292270118.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 16:05:47 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently mac80211 hw data is accessed by convert the hw to radio (ar)
> structure and then radio to hw structure which is not necessary in some
> places where mac80211 hw data is already present. So in that kind of
> places avoid the conversion and directly access the mac80211 hw data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

842addae0208 wifi: ath12k: Optimize the mac80211 hw data access
940b57fd0e77 wifi: ath12k: avoid repeated hw access from ar

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231120235812.2602198-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


