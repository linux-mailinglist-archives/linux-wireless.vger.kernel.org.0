Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6C621783
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 15:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiKHO4v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiKHO4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 09:56:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513C2CE16
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 06:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70058615DD
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14053C433D6;
        Tue,  8 Nov 2022 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667919408;
        bh=0sUdFUp/JKQ9HD+qKj1AlZzNDG4QGE5+QW4W3Z0QinE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cQ5Arhwj6EV5XWKF1BZI74UsQoPLbxsS6E1jEKPpwXl9a5AF+334XvMLF4DVurm5+
         IBNNcyTA9WL/HHzAOkUEuwzN7w1DDrCZ7Bl2PrDirOwFeZpcggfLwHQDMDeK1F+roO
         fgBPpnuESS5R23ceHLO/cWUlJDwJ7U8iTwgtMlvYKnileEqCruNg56vz/GOtpsQckT
         GdTQSevk2eszZIYOD0r+xWVuclx0dI8Nuwd1QRRf8tk6w+boUR5Ok3ORDMvwSocnbR
         PsJz8l8PRzdONw7Yu0KRp8BzbDyxBWpMyFlqFdNJlZNf+FDdMb1w7FItMa1pcRgWoh
         6gHNdcV89Oudg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 36/50] wifi: ath12k: add pci.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-37-kvalo@kernel.org>
        <d6323a12-0a7c-af50-7fc6-d996eb24a02f@quicinc.com>
Date:   Tue, 08 Nov 2022 16:56:45 +0200
In-Reply-To: <d6323a12-0a7c-af50-7fc6-d996eb24a02f@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 16:18:04 -0700")
Message-ID: <87zgd1cx5e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/pci.h | 132 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 132 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/pci.h
>> b/drivers/net/wireless/ath/ath12k/pci.h
> [...]
>> +struct ath12k_msi_user {
>> +	char *name;
>
> should this be const?

Fixed.

>> +	int num_vectors;
>> +	u32 base_vector;
>> +};
>> +
>> +struct ath12k_msi_config {
>> +	int total_vectors;
>> +	int total_users;
>> +	struct ath12k_msi_user *users;
>
> should this be const?

This is fixed.

> then the following typecast in pci.c would not be necessary:
>
> static const struct ath12k_msi_config ath12k_msi_config[] = {
> 	{
> [...]
> 		.users = (struct ath12k_msi_user[]) {
> [...]
> 		},
> [...]

But I couldn't figure out how to remove the cast, I got compiler errors
whatever I tried. I added to todo and will revisit later.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
