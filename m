Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7763621722
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 15:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiKHOpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 09:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiKHOpo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 09:45:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE210A8
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 06:45:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC205B81B08
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 14:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81372C433D6;
        Tue,  8 Nov 2022 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667918740;
        bh=2kooCGud+rjaS6L4Gd38qK6vl6TzkcqcMznVDB1kckk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wqa17tY9DUXPi1vEdkphMT+axzdEDC3HrORIIEzjpzy3ODMARrJ4UmUfF4laAiyaW
         8ioN1T1zlk7BUeQjoXsgec9ZPr7xcl57YgJdjEM+KRrPRJ+xMQb3whcBS331dfoLVt
         buxvPQYZNESDcT+RRRQY0eNERL+dA1mFzApIWgZ/cuQbzyECkJNq9AvhGYIi6MsQnP
         1D8guavBxaU1JA/wBjBsFVGUJ9oy+GwJlafR3M6CAEvvAMNTsY/7Mietj8E6jhKyFH
         f4B9xAHF/wmjHb3S+9MY3RjkvQz8IusMhqzOOzcPJelScgPge6E/pCEg27D1AxFPb2
         g8l+asUZCiBLA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 35/50] wifi: ath12k: add pci.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-36-kvalo@kernel.org>
        <7b06d248-c976-6c9f-4d5c-5dec7b1d5511@quicinc.com>
Date:   Tue, 08 Nov 2022 16:45:37 +0200
In-Reply-To: <7b06d248-c976-6c9f-4d5c-5dec7b1d5511@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 16:02:14 -0700")
Message-ID: <878rklec8e.fsf@kernel.org>
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
>>   drivers/net/wireless/ath/ath12k/pci.c | 1344 +++++++++++++++++++++++++++++++++
>>   1 file changed, 1344 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/pci.c
>> b/drivers/net/wireless/ath/ath12k/pci.c
>
> snip
>
>> +static void ath12k_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct ath12k_base *ab = pci_get_drvdata(pdev);
>> +	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
>> +
>> +	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
>> +		ath12k_pci_power_down(ab);
>> +		ath12k_qmi_deinit_service(ab);
>> +		goto qmi_fail;
>> +	}
>> +
>> +	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
>> +
>> +	cancel_work_sync(&ab->reset_work);
>> +	ath12k_core_deinit(ab);
>> +
>> +qmi_fail:
>> +	ath12k_mhi_unregister(ab_pci);
>> +
>> +	ath12k_pci_free_irq(ab);
>> +	ath12k_pci_msi_free(ab_pci);
>> +	ath12k_pci_free_region(ab_pci);
>> +
>> +	ath12k_hal_srng_deinit(ab);
>> +	ath12k_ce_free_pipes(ab);
>> +	destroy_workqueue(ab->workqueue_aux);
>
> it seems strange/asymetrical to destroy this here.
>
> it was allocated in ath12k_core_alloc() so I'd expect it to be
> destroyed in ath12k_core_free() to maintain symmetry

Fixed.

> in addition I don't see ab->workqueue being destroyed, and imo that
> should also take place in ath12k_core_free() for the same reason

This is also fixed.

>> +static SIMPLE_DEV_PM_OPS(ath12k_pci_pm_ops,
>> +			 ath12k_pci_pm_suspend,
>> +			 ath12k_pci_pm_resume);
>> +
>> +static struct pci_driver ath12k_pci_driver = {
>> +	.name = "ath12k_pci",
>> +	.id_table = ath12k_pci_id_table,
>> +	.probe = ath12k_pci_probe,
>> +	.remove = ath12k_pci_remove,
>> +	.shutdown = ath12k_pci_shutdown,
>> +#ifdef CONFIG_PM
>> +	.driver.pm = &ath12k_pci_pm_ops,
>> +#endif
>
> conditional compilation is unnecessary here since SIMPLE_DEV_PM_OPS
> handles the conditional

Fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
