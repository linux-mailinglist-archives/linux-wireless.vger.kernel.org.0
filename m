Return-Path: <linux-wireless+bounces-15785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D41B9DB7C4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 13:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5374287076
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88119DF8D;
	Thu, 28 Nov 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5enbyc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53F19DF77
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797268; cv=none; b=aMpZuo17SZI6rsuyJv9KoT1N6mbH0VIni2KnFs3mOueXx7Ipc3tII5vXJ5ht/XryszjXwtKBQAnLTRhRPNbGPdMwO2HGWhzlpVJ+Ez+SbrmjW37X+HyhGTU1iFnBSABTjEKLTWld67Uf4aIjom5W5A1yIeGL14h4+U/53vlnveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797268; c=relaxed/simple;
	bh=7/2hs8AYAHMb0J5u/xgcDIRS+q0MfawTUy4a/6t6x9w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kVIfW1TBVqc1L/qvneM1x/I36/CuLbloL4sAulXjaNiQMq01Aikt+IDBkR5GKG+EPP4pYMuvWY2tY81om/07jJkpeLmS+Kkk9wyuniVNMhL24b0lKzUvQ49vC14cWf7dLS0dol/ZP6jY3dhGky4Tsw3ul591GI3TlXTX4J60mNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5enbyc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836D0C4CED3;
	Thu, 28 Nov 2024 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797268;
	bh=7/2hs8AYAHMb0J5u/xgcDIRS+q0MfawTUy4a/6t6x9w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Z5enbyc/yeZptP87dza6mlfkGlqRtbuCZeblkRrAFx14MmEEkhdV6+4aIZtfpCALz
	 PPCzOdzj09dxdzLnTazpy+Vi2/ANjtmIFvX8JVAqkpVY06Edw5KtV7i9sKaUHY6TjZ
	 ldtGzjsJH4yRGtlZ4Y84bRCPheQqai9k5U1FeIbz7I6kgTiwL6l1pmowVBu27jBW+f
	 pJwzTLLXgpYeiQQ+29GtIOR9RJVxJKqqeeFalXTAYN54F8WtXDc8WYzIKj2/0Ie4c9
	 /gRLzrT5S27itW52P+vmfwIZu9PsRQHgBKh7xyw8aySKs9D2mBihJplkrRZsuUFnMC
	 A4ZMAtUAM7eMQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 06/10] wifi: ath12k: do not return invalid link id for
 scan link
References: <20241126171139.2350704-1-kvalo@kernel.org>
	<20241126171139.2350704-7-kvalo@kernel.org>
	<abf0db61-326d-4b06-8ced-66d5f96d8dc0@quicinc.com>
Date: Thu, 28 Nov 2024 14:34:25 +0200
In-Reply-To: <abf0db61-326d-4b06-8ced-66d5f96d8dc0@quicinc.com> (Baochen
	Qiang's message of "Wed, 27 Nov 2024 11:06:23 +0800")
Message-ID: <87plmfv8oe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/27/2024 1:11 AM, Kalle Valo wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>> 
>> @@ -4317,14 +4327,14 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>>  					 struct ieee80211_vif *vif)
>>  {
>>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>> +	u16 link_id = ahvif->last_scan_link;
>>  	struct ath12k_link_vif *arvif;
>>  	struct ath12k *ar;
>>  
>>  	lockdep_assert_wiphy(hw->wiphy);
>>  
>> -	arvif = &ahvif->deflink;
>> -
>> -	if (!arvif->is_created)
>> +	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
>> +	if (!arvif || arvif->is_created)
>
> s/arvif->is_created/!arvif->is_created/ ?

Another good catch! Fixed now.

>> @@ -7990,6 +8011,19 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>>  	if (!ar)
>>  		return NULL;
>>  
>> +	/* cleanup the scan vdev if we are done scan on that ar
>> +	 * and now we want to create for actual usage.
>> +	 */
>> +	if (vif->valid_links) {
>
> better to use ieee80211_vif_is_mld()?

Yup, fixed in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=54504518cb26fef3dbaf16457cde91a9fd7e9c3d

Thanks for the detailed review, very much appreciated.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

