Return-Path: <linux-wireless+bounces-29223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23367C77668
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 06:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FF884E3D20
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 05:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180242D8367;
	Fri, 21 Nov 2025 05:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ccd7hTV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster2-host11-snip4-10.eps.apple.com [57.103.64.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9126FDBF
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703746; cv=none; b=Kg789ZnOJGRX60mx5rLvxuqiirX7UMBxmN4w6wqOivBg0OKYZf2J6RmmrwKH5vkQaQ8nVqVT3T3UeNeoCZf206hFkCYmdeloSTkgk5R+LOodMn1v2qm5YMQKHFEhgzjDeNdjCHnW7MBt4zaPXP8L8GMXK3VoVAAiswOxutszNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703746; c=relaxed/simple;
	bh=wJ2dKMvB9zuLFjL5d1XbmjHOx6q8AmjcNyJf+x7wm3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKAj34+h4D8pX6CgJipDeVh6oE7/SkonCglknbJRxSt2h60Mv4U4MWCj69NUg+/S0hYbkXpzIokNYbRZw1wlDmZ56NmuxHt+rjqI4e+eP/LEPKQx5DzvKww+16CEZKnml2tfmXHzgHUxCHcIlgUsvnY1s/l9bgWs96euS2tKeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ccd7hTV2; arc=none smtp.client-ip=57.103.64.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id E8497180014E;
	Fri, 21 Nov 2025 05:42:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=4Zs9GRvm32PNjZzoA8qlvAE406gaQ36xltOhqAM2veQ=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=Ccd7hTV2ROk7BDrGaaCgAkdal7/2NvRZPmuB6pZRomMoX+gklQEmhrqkTpo5tH67Tolqh8wKIIvWutj21AMzr/DVWryE1n6itXLBtEd3b9NGVEKB+uA3drYh4roAYmGWzqiKOMtBNzpH2q4cBju4GO7LcuiPhr2lvI98JYoWZ2W+7f73su6xbQpx2+lfs1yL3SWJP+cpjI1ZxzUTEKpJytV4dmdVeoIBHcl5ECuYJge0cGKOlJPDkzUEolqiMpEoi3ASGr1Vj7k1MhOuemZ2ofnxF8ju+KdY1qKPZlA8Ocrk1LsAmnz78xK1o9z4ZJ7ClV0vu2LDjPFlCntziqX/BA==
Received: from [172.31.0.10] (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id EA4A218000A0;
	Fri, 21 Nov 2025 05:42:19 +0000 (UTC)
Message-ID: <780b6778-ea0e-4fc9-8f35-83b5cd4940af@icloud.com>
Date: Thu, 20 Nov 2025 21:42:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mt76 1/2] Revert "wifi: mt76: mt792x: improve monitor
 interface handling"
To: Fedor Pchelkin <pchelkin@ispras.ru>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
 <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matvey Kovalev
 <matvey.kovalev@ispras.ru>, lvc-project@linuxtesting.org
References: <20251027111843.38975-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Alex Gavin <a_gavin@icloud.com>
In-Reply-To: <20251027111843.38975-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Info: v=2.4 cv=T/2BjvKQ c=1 sm=1 tr=0 ts=691ffbbe cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=x7bEGLp0ZPQA:10 a=h3XwevFeXowA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HH5vDtPzAAAA:8 a=xjQjg--fAAAA:8
 a=NfBt78jllEJdnomDNvIA:9 a=QEXdDO2ut3YA:10 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-ORIG-GUID: xqec2kQ6ReU-W5E9VoidnOuMpYXd7nHv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA0MyBTYWx0ZWRfX/QhFid0JZdY6
 L0yfZxQEOV74tRAzQEamz3rlbMCh7yMr2i+vNLSnvgfnTJREd0y9RiLKrCk8ZlSkFXq/TfWWxRs
 bBkLLUTMx1NlgCQuhyWVQ9axj/0kBSFmeiYKHiMY/RI8KgBYac8bF6zjUjEM903FPqG1FAYkEiB
 iYp7YNU21gcGtw7j6wROw+nEJDlNfPGSJmgMJvJTtNmWeuKI9zt+IEykbUDf5Dce8hAiDsTHffi
 d1KJBOkvlHCDSGXyXgAIst66nTlhIbQWiEZ2YqQClECKTvXDeF7AeUEathI+pQ1dW/Ux+E0pEi8
 7ytEfPQp9ffmc8nG4za
X-Proofpoint-GUID: xqec2kQ6ReU-W5E9VoidnOuMpYXd7nHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210043
X-JNJ: AAAAAAABmYUlTjxPqxU886FK+jlSf8uaaEDanEEde9JRREjw0e6s1eg9FZO29EPN29zZoyP2kjex7XdZaGP/k5G7Fkm2AYqAr9vAn2k1TWTlS6etMEf1c+A+Jvf7n3gCdX3PIPHQsoWt+qeuwY286Shy+LNqpTDqHsY8qQhDpG1tIidxfbrXZLbvta5PFX86mKl/qkf+FREgRPTWLQG7roYOagcbvWCsTnvnlqNnCr3+d5DHLXFjBkR5EEfWUbJZnxDBvGV6BtlrxxQbx5weNwwQda0NyQylK3gGt+Sj1HuaxFK9GOm6cCaEc4wjR857/JqLPOQ6TGIgzzvH8UAPbqK8fJ78/QwgOGrPqc9oGusWoRd9T0woQB6wxvQP5r4yMmL4m4MvcFgP00/4xMVnOVVz12p6Bem4NT4dVTEYnpXEw6Um1Q52xJ9fJ3dE7fijGbXFyxDpVbBz9OskwvSKw/db01+t0vm0y5N8UIEt5zb+5caxBuFXbpOygdR/SxR4fPnMdBiQKafJcUWsbkVP5JRBPYWnPXt7r9we3oEHktvFTLSRfHkzo6lfHtR93PUfg2Pc/UW2pJk7CpjfG3WTWDYeWa8t8xvBALqh3B+CcoqK3cgyFdbCCIEc8vizSJVcucVn5ggCfS3Sd+AWWnQ3R2ajn4AmclFEIEZLye9GzJuGXA8NAnwl2gWDgFA3YNbiMHq4zvs0vqdvwBPI3rDxvmCExew4Sc3tNxY4Q6/xFRK/HcUrXq2QC0645NfGrrqbl/DvRu1Bxdc2ZUYY2jZNEw9gO9KvANRFjqLNbwckDXfyyy/Ec+HgSs2t3njFXtzijtxSLAk=

On 10/27/25 04:18, Fedor Pchelkin wrote:
> This reverts commit 55e95ce469d0c61041bae48b2ebb7fcbf6d1ba7f.
> 
> mt792x drivers don't seem to support multi-radio devices yet.  At least
> they don't mess with `struct wiphy_radio` at the moment.
> 
> Packet capturing on monitor interface doesn't work after the blamed patch:
> 
>   tcpdump -i wls6mon -n -vvv
> 
> Revert the NO_VIRTUAL_MONITOR feature for now to resolve the issue.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 55e95ce469d0 ("wifi: mt76: mt792x: improve monitor interface handling")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> 
> Can't answer exactly *why* the capturing doesn't work after the patch:
> probably because the driver is just not prepared for NO_VIRTUAL_MONITOR.
> The feature isn't too obvious, especially that for some reason it was set
> in mt792x alongside WANT_MONITOR_VIF.  With a quick glance I might
> conclude that NO_VIRTUAL_MONITOR overrides WANT_MONITOR_VIF, they don't
> look compatible.
> 
>  drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> index 5b50bf94996e..f2ed16feb6c1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -688,7 +688,6 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
>  	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
>  	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
>  	ieee80211_hw_set(hw, CONNECTION_MONITOR);
> -	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
>  	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
>  	ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
>  

This patch fixed monitor vif-only packet capture for me when using both mt7921 and mt7921au chipset
radios. Without it I was only seeing broadcast and multicast traffic I believe. Tested using vanilla
6.18.0-rc6 as base.


