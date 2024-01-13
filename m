Return-Path: <linux-wireless+bounces-1873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24182CAEA
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 10:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2038DB21B67
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5AEC5;
	Sat, 13 Jan 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvqWcWqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C1A3F
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 09:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C082C433C7;
	Sat, 13 Jan 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705139079;
	bh=1hvDFRV24xJJKkGg0jYO3A1J1KEhcdugByo3G/yj7Dw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fvqWcWqtTrHxllZ17lSGnOeJciIg627H7RZMhPFhyFImMVvFRvItdWCFNMzykwYli
	 AOi/QuzHHoFDTMhVsVFh5Cc3VpREmNQK5q3717epyYGH+weq3RZuB9Pnsqz8NbM6Yd
	 gNnezmr46goqzAaazhkQLF4dV4IkYzdCabnenIShU64nbvMMEwPuxBLMpc0olEf5dj
	 QGRWWDx+H3lYFM6oQhTyTLR51GlrsZNLjUJKmw7sAbbhodVD4hTi7YsgQGa8DVVVhM
	 wG4itUKEtvsBf/4tAsUJPyb/YzCSLygfAWmPGziSo0jwjJ+Lo4+aEGFZpxinAm65IF
	 +tmMeJiyFoDsg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Sriram R <quic_srirrama@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 07/12] wifi: ath12k: Cache vdev configs before vdev create
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
	<20240111045045.28377-8-quic_srirrama@quicinc.com>
	<c35da30b-335c-4418-9d7c-0784ec9e8d30@quicinc.com>
Date: Sat, 13 Jan 2024 11:44:36 +0200
In-Reply-To: <c35da30b-335c-4418-9d7c-0784ec9e8d30@quicinc.com> (Jeff
	Johnson's message of "Fri, 12 Jan 2024 09:23:59 -0800")
Message-ID: <87cyu5h8jf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>> +static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>> +				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
>> +				 struct ieee80211_key_conf *key)
>> +{
>> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> +	struct ath12k *ar;
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	int ret;
>> +
>> +	/* BIP needs to be done in software */
>> +	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
>> +		return 1;
>
> I know this in the existing code, but what is the significance of
> returning 1? Should this be returning a -errno like the error cases that
> follow?

It's to use software encryption, from mac80211.h:

 * Note that in the case that the @IEEE80211_HW_SW_CRYPTO_CONTROL flag is
 * set, mac80211 will not automatically fall back to software crypto if
 * enabling hardware crypto failed. The set_key() call may also return the
 * value 1 to permit this specific key/algorithm to be done in software.

Yeah, this is confusing. IMHO there should be a define or an enum for
this value.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

