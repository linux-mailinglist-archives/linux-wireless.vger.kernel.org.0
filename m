Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D222015FD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2020 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394710AbgFSQY5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jun 2020 12:24:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19252 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394806AbgFSQYy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jun 2020 12:24:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592583893; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mXJdDC2hfvuYe5kBaaVL6RFz62vgkC1W/BsD+CIz5dM=;
 b=e81kJ2zI+SgxBruoglyz+obkeE8npO/JYtF57jqdPuEY4dt/Lsolm6tZ6S494CLQYR9rSLxC
 aIh3waVDfs094Xhy42bpEItQl8rczEgg4fcNcY4GSRvyv8uUZ3XIbf/ZwuoFjCnKQfxPqxkZ
 u5MKBw5z9THusPXnZRvarVPf1r0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5eece6cd567385e8e7000d8a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Jun 2020 16:24:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2511BC433C8; Fri, 19 Jun 2020 16:24:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40995C433A0;
        Fri, 19 Jun 2020 16:24:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Jun 2020 21:54:42 +0530
From:   akolli@codeaurora.org
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     ath11k@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ath11k: copy ce service configs to hw_params
In-Reply-To: <CAGRGNgV74fCD1gb=rXEe1BMN5+5stYeX3W6eKc4-do76TBmFqA@mail.gmail.com>
References: <1592458104-2961-1-git-send-email-akolli@codeaurora.org>
 <1592458104-2961-3-git-send-email-akolli@codeaurora.org>
 <CAGRGNgV74fCD1gb=rXEe1BMN5+5stYeX3W6eKc4-do76TBmFqA@mail.gmail.com>
Message-ID: <34ed705f28b40fab493b8c888138e6a7@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-19 04:40, Julian Calaby wrote:
> Hi Anilkumar,
> 
> On Thu, Jun 18, 2020 at 3:31 PM Anilkumar Kolli <akolli@codeaurora.org> 
> wrote:
>> 
>> No functional changes, added target ce service configurations
>> to hw_params.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> ---
>> V3:
>>  - added ce svc configs in hw_params
>> 
>>  drivers/net/wireless/ath/ath11k/ahb.c  | 20 +++++++++++++++-----
>>  drivers/net/wireless/ath/ath11k/core.c |  8 +-------
>>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>>  drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
>>  4 files changed, 19 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c 
>> b/drivers/net/wireless/ath/ath11k/ahb.c
>> index 7e9bfeaaf4d2..aa74d27e5871 100644
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -152,7 +152,7 @@ static const struct ce_pipe_config 
>> target_ce_config_wlan[] = {
>>   * This table is derived from the CE_PCI TABLE, above.
>>   * It is passed to the Target at startup for use by firmware.
>>   */
>> -static const struct service_to_pipe target_service_to_ce_map_wlan[] = 
>> {
>> +static const struct service_to_pipe 
>> target_service_to_ce_map_wlan_ipq8074[] = {
>>         {
>>                 .service_id = 
>> __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
>>                 .pipedir = __cpu_to_le32(PIPEDIR_OUT),  /* out = UL = 
>> host -> target */
>> @@ -644,8 +644,8 @@ static void ath11k_ahb_init_qmi_ce_config(struct 
>> ath11k_base *ab)
>> 
>>         cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
>>         cfg->tgt_ce = target_ce_config_wlan;
>> -       cfg->svc_to_ce_map_len = 
>> ARRAY_SIZE(target_service_to_ce_map_wlan);
>> -       cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
>> +       cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
>> +       cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
>>  }
>> 
>>  static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
>> @@ -853,8 +853,8 @@ static int ath11k_ahb_map_service_to_pipe(struct 
>> ath11k_base *ab, u16 service_id
>>         bool ul_set = false, dl_set = false;
>>         int i;
>> 
>> -       for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); 
>> i++) {
>> -               entry = &target_service_to_ce_map_wlan[i];
>> +       for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
>> +               entry = &ab->hw_params.svc_to_ce_map[i];
>> 
>>                 if (__le32_to_cpu(entry->service_id) != service_id)
>>                         continue;
>> @@ -950,6 +950,16 @@ static int ath11k_ahb_probe(struct 
>> platform_device *pdev)
>>                 goto err_hal_srng_deinit;
>>         }
>> 
>> +       ret = ath11k_init_hw_params(ab);
>> +       if (ret) {
>> +               ath11k_err(ab, "failed to get hw params %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ab->hw_params.svc_to_ce_map_len =
>> +                       
>> ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
>> +       ab->hw_params.svc_to_ce_map = 
>> target_service_to_ce_map_wlan_ipq8074;
> 
> I think you misunderstood my point about this, the point wasn't to
> copy the svc map to hw_params, but define it in hw_params:
> 
> +       {
> +               .hw_rev = ATH11K_HW_IPQ6018,
> +               .name = "ipq6018 hw1.0",
> +               .fw = {
> +                       .dir = "IPQ6018/hw1.0",
> +                       .board_size = 256 * 1024,
> +                       .cal_size = 256 * 1024,
> +               },
> +               .max_radios = 2,
> +               .bdf_addr = 0x4ABC0000,
> +               .hw_ops = &ipq6018_ops,
> +               .svc_to_ce_map_len =
> ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018,
> +               .svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018,
> +       },
> 
> That completely eliminates special case code based on the hardware ID
> in the driver.
> 
The static array of structures target_service_to_ce_map_wlan_ipq6018[] 
is defined in ahb.c and hw_params are initialised in core.c, this will 
not work. no?

Thanks
Anil
