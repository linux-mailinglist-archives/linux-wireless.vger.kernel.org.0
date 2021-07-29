Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B03D99DE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 02:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhG2AGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 20:06:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52827 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhG2AGj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 20:06:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627517196; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0Qnv3g6Y4e2x53HIT6VYGOhkktWjimmtW9iO/zRgVgc=;
 b=MA9u6s3mQy8km7I9dA3Jb5QRIPjWzvolmXibqHS9lgNXaB8ciIIsdZsQj0YSGWWPnjWHXTqt
 UdYC7+U0uL68TDty0QstXmI/k0KnNoxwDGwv9jdZHQnvRk0qMmt9ULuzJ64gUxct3jmDV2BR
 1ozrTnhZk/2Z6t5dK5ssIXiSNNk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6101f10296a66e66b288ae28 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 00:06:26
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D69D0C4338A; Thu, 29 Jul 2021 00:06:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 659CDC433D3;
        Thu, 29 Jul 2021 00:06:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Jul 2021 17:06:24 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     kvalo@codeaurora.org, ath11k@lists.infradead.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5] bus: mhi: core: Add support for processing priority of
 event ring
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <9300cf49a498521f471d6106131bd675@codeaurora.org>
References: <1624641728-3886-1-git-send-email-bbhatt@codeaurora.org>
 <20210716114926.GH3323@workstation>
 <9300cf49a498521f471d6106131bd675@codeaurora.org>
Message-ID: <9561c5a41e1707d694b1c872fea399de@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 2021-07-16 11:22 AM, Bhaumik Bhatt wrote:
> Hi Mani,
> 
> On 2021-07-16 04:49 AM, Manivannan Sadhasivam wrote:
>> On Fri, Jun 25, 2021 at 10:22:08AM -0700, Bhaumik Bhatt wrote:
>>> From: Hemant Kumar <hemantk@codeaurora.org>
>>> 
>>> Event ring priorities are currently set to 1 and are unused.
>>> Default processing priority for event rings is set to regular
>>> tasklet. Controllers can choose to use high priority tasklet
>>> scheduling for certain event rings critical for processing such
>>> as ones transporting control information if they wish to avoid
>>> system scheduling delays for those packets. In order to support
>>> these use cases, allow controllers to set event ring priority to
>>> high.
>>> 
>> 
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> 
>> Just curious, what are the event rings you are going to make as high
>> priority? If you are going to do that for existing controllers, please
>> submit a patch now itself.
>> 
>> Thanks,
>> Mani
>> 
> Idea for this patch came from 914b72a6948b ("bus: mhi: Wait for M2
> state during system resume").
> 
> If WLAN ath11k controller driver wants to avoid the scenario mentioned 
> in
> the above patch, it will help them to have a high priority for their 
> dedicated
> control events ring.
> 
> I would defer to Kalle and others in ath11k, whether or not they are
> OK to take that route.
> as an update to priority will just help return from resume faster.
> It will also depend on system load/reproducibility rate of the 
> scenario.
> 
> I can provide a patch for them to review/test since I do not have the
> setup for it.
> 
Would you like to try this patch out? It basically increases the 
priority
at which the control events for M0/M1/M3 state changes are handled.

Let me know if you have any questions.

>>> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>> ---
>>> v5:
>>> -Add controller changes and enable usage of event ring configuration 
>>> priorities
>>> -Fix nitpick, use high instead of hi in kdoc
>>> 
>>> v4:
>>> -Update fixed priority for all events to default to fix bug in v3
>>> -Supply changelog
>>> 
>>> v3:
>>> -Revert to enum approach
>>> -Use 0 as default and 1 as high in enum
>>> -Do not use config values for event rings
>>> 
>>> v2:
>>> -Use boolean approach for easy maintenance as controllers do not need 
>>> updates
>>> 
>>> 
>>> 
>>>  drivers/bus/mhi/core/init.c           |  3 +-
>>>  drivers/bus/mhi/core/internal.h       |  2 +-
>>>  drivers/bus/mhi/core/main.c           | 19 ++++++++--
>>>  drivers/bus/mhi/pci_generic.c         | 66 
>>> +++++++++++++++++------------------
>>>  drivers/net/wireless/ath/ath11k/mhi.c |  4 +--
>>>  include/linux/mhi.h                   | 14 ++++++--
>>>  6 files changed, 65 insertions(+), 43 deletions(-)
>>> 
>>> diff --git a/drivers/bus/mhi/core/init.c 
>>> b/drivers/bus/mhi/core/init.c
>>> index c81b377..4446760 100644
>>> --- a/drivers/bus/mhi/core/init.c
>>> +++ b/drivers/bus/mhi/core/init.c
>>> @@ -673,8 +673,7 @@ static int parse_ev_cfg(struct mhi_controller 
>>> *mhi_cntrl,
>>>  				&mhi_cntrl->mhi_chan[mhi_event->chan];
>>>  		}
>>> 
>>> -		/* Priority is fixed to 1 for now */
>>> -		mhi_event->priority = 1;
>>> +		mhi_event->priority = event_cfg->priority;
>>> 
>>>  		mhi_event->db_cfg.brstmode = event_cfg->mode;
>>>  		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
>>> diff --git a/drivers/bus/mhi/core/internal.h 
>>> b/drivers/bus/mhi/core/internal.h
>>> index 672052f..666e102 100644
>>> --- a/drivers/bus/mhi/core/internal.h
>>> +++ b/drivers/bus/mhi/core/internal.h
>>> @@ -535,7 +535,7 @@ struct mhi_event {
>>>  	u32 intmod;
>>>  	u32 irq;
>>>  	int chan; /* this event ring is dedicated to a channel (optional) 
>>> */
>>> -	u32 priority;
>>> +	enum mhi_er_priority priority;
>>>  	enum mhi_er_data_type data_type;
>>>  	struct mhi_ring ring;
>>>  	struct db_cfg db_cfg;
>>> diff --git a/drivers/bus/mhi/core/main.c 
>>> b/drivers/bus/mhi/core/main.c
>>> index 8ac73f9..bfc9776 100644
>>> --- a/drivers/bus/mhi/core/main.c
>>> +++ b/drivers/bus/mhi/core/main.c
>>> @@ -425,10 +425,11 @@ void mhi_create_devices(struct mhi_controller 
>>> *mhi_cntrl)
>>>  	}
>>>  }
>>> 
>>> -irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>>> +irqreturn_t mhi_irq_handler(int irq_number, void *priv)
>>>  {
>>> -	struct mhi_event *mhi_event = dev;
>>> +	struct mhi_event *mhi_event = priv;
>>>  	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>>  	struct mhi_event_ctxt *er_ctxt =
>>>  		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
>>>  	struct mhi_ring *ev_ring = &mhi_event->ring;
>>> @@ -454,8 +455,20 @@ irqreturn_t mhi_irq_handler(int irq_number, void 
>>> *dev)
>>> 
>>>  		if (mhi_dev)
>>>  			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
>>> -	} else {
>>> +
>>> +		return IRQ_HANDLED;
>>> +	}
>>> +
>>> +	switch (mhi_event->priority) {
>>> +	case MHI_ER_PRIORITY_HI:
>>> +		tasklet_hi_schedule(&mhi_event->task);
>>> +		break;
>>> +	case MHI_ER_PRIORITY_DEFAULT:
>>>  		tasklet_schedule(&mhi_event->task);
>>> +		break;
>>> +	default:
>>> +		dev_err(dev, "Skip event of unknown priority\n");
>>> +		break;
>>>  	}
>>> 
>>>  	return IRQ_HANDLED;
>>> diff --git a/drivers/bus/mhi/pci_generic.c 
>>> b/drivers/bus/mhi/pci_generic.c
>>> index 31360a2..5886547 100644
>>> --- a/drivers/bus/mhi/pci_generic.c
>>> +++ b/drivers/bus/mhi/pci_generic.c
>>> @@ -74,17 +74,17 @@ struct mhi_pci_dev_info {
>>>  		.doorbell_mode_switch = false,		\
>>>  	}
>>> 
>>> -#define MHI_EVENT_CONFIG_CTRL(ev_ring, el_count) \
>>> -	{					\
>>> -		.num_elements = el_count,	\
>>> -		.irq_moderation_ms = 0,		\
>>> -		.irq = (ev_ring) + 1,		\
>>> -		.priority = 1,			\
>>> -		.mode = MHI_DB_BRST_DISABLE,	\
>>> -		.data_type = MHI_ER_CTRL,	\
>>> -		.hardware_event = false,	\
>>> -		.client_managed = false,	\
>>> -		.offload_channel = false,	\
>>> +#define MHI_EVENT_CONFIG_CTRL(ev_ring, el_count)	\
>>> +	{						\
>>> +		.num_elements = el_count,		\
>>> +		.irq_moderation_ms = 0,			\
>>> +		.irq = (ev_ring) + 1,			\
>>> +		.priority = MHI_ER_PRIORITY_DEFAULT,	\
>>> +		.mode = MHI_DB_BRST_DISABLE,		\
>>> +		.data_type = MHI_ER_CTRL,		\
>>> +		.hardware_event = false,		\
>>> +		.client_managed = false,		\
>>> +		.offload_channel = false,		\
>>>  	}
>>> 
>>>  #define MHI_CHANNEL_CONFIG_HW_UL(ch_num, ch_name, el_count, ev_ring) 
>>> \
>>> @@ -177,31 +177,31 @@ struct mhi_pci_dev_info {
>>>  		.doorbell_mode_switch = false,		\
>>>  	}
>>> 
>>> -#define MHI_EVENT_CONFIG_DATA(ev_ring, el_count) \
>>> -	{					\
>>> -		.num_elements = el_count,	\
>>> -		.irq_moderation_ms = 5,		\
>>> -		.irq = (ev_ring) + 1,		\
>>> -		.priority = 1,			\
>>> -		.mode = MHI_DB_BRST_DISABLE,	\
>>> -		.data_type = MHI_ER_DATA,	\
>>> -		.hardware_event = false,	\
>>> -		.client_managed = false,	\
>>> -		.offload_channel = false,	\
>>> +#define MHI_EVENT_CONFIG_DATA(ev_ring, el_count)	\
>>> +	{						\
>>> +		.num_elements = el_count,		\
>>> +		.irq_moderation_ms = 5,			\
>>> +		.irq = (ev_ring) + 1,			\
>>> +		.priority = MHI_ER_PRIORITY_DEFAULT,	\
>>> +		.mode = MHI_DB_BRST_DISABLE,		\
>>> +		.data_type = MHI_ER_DATA,		\
>>> +		.hardware_event = false,		\
>>> +		.client_managed = false,		\
>>> +		.offload_channel = false,		\
>>>  	}
>>> 
>>>  #define MHI_EVENT_CONFIG_HW_DATA(ev_ring, el_count, ch_num) \
>>> -	{					\
>>> -		.num_elements = el_count,	\
>>> -		.irq_moderation_ms = 1,		\
>>> -		.irq = (ev_ring) + 1,		\
>>> -		.priority = 1,			\
>>> -		.mode = MHI_DB_BRST_DISABLE,	\
>>> -		.data_type = MHI_ER_DATA,	\
>>> -		.hardware_event = true,		\
>>> -		.client_managed = false,	\
>>> -		.offload_channel = false,	\
>>> -		.channel = ch_num,		\
>>> +	{						\
>>> +		.num_elements = el_count,		\
>>> +		.irq_moderation_ms = 1,			\
>>> +		.irq = (ev_ring) + 1,			\
>>> +		.priority = MHI_ER_PRIORITY_DEFAULT,	\
>>> +		.mode = MHI_DB_BRST_DISABLE,		\
>>> +		.data_type = MHI_ER_DATA,		\
>>> +		.hardware_event = true,			\
>>> +		.client_managed = false,		\
>>> +		.offload_channel = false,		\
>>> +		.channel = ch_num,			\
>>>  	}
>>> 
>>>  static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] 
>>> = {
>>> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c 
>>> b/drivers/net/wireless/ath/ath11k/mhi.c
>>> index 27b394d..b7864fc 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mhi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
>>> @@ -86,7 +86,7 @@ static struct mhi_event_config 
>>> ath11k_mhi_events_qca6390[] = {
>>>  		.irq_moderation_ms = 1,
>>>  		.irq = 2,
>>>  		.mode = MHI_DB_BRST_DISABLE,
>>> -		.priority = 1,
>>> +		.priority = MHI_ER_PRIORITY_DEFAULT,
>>>  		.hardware_event = false,
>>>  		.client_managed = false,
>>>  		.offload_channel = false,
>>> @@ -179,7 +179,7 @@ static struct mhi_event_config 
>>> ath11k_mhi_events_qcn9074[] = {
>>>  		.irq_moderation_ms = 1,
>>>  		.irq = 2,
>>>  		.mode = MHI_DB_BRST_DISABLE,
>>> -		.priority = 1,
>>> +		.priority = MHI_ER_PRIORITY_DEFAULT,
>>>  		.hardware_event = false,
>>>  		.client_managed = false,
>>>  		.offload_channel = false,
>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>>> index 86cea52..3e92e85 100644
>>> --- a/include/linux/mhi.h
>>> +++ b/include/linux/mhi.h
>>> @@ -198,6 +198,16 @@ enum mhi_er_data_type {
>>>  };
>>> 
>>>  /**
>>> + * enum mhi_er_priority - Event ring processing priority
>>> + * @MHI_ER_PRIORITY_DEFAULT: processed by regular tasklet
>>> + * @MHI_ER_PRIORITY_HI: processed by high priority tasklet
>>> + */
>>> +enum mhi_er_priority {
>>> +	MHI_ER_PRIORITY_DEFAULT,
>>> +	MHI_ER_PRIORITY_HI,
>>> +};
>>> +
>>> +/**
>>>   * enum mhi_db_brst_mode - Doorbell mode
>>>   * @MHI_DB_BRST_DISABLE: Burst mode disable
>>>   * @MHI_DB_BRST_ENABLE: Burst mode enable
>>> @@ -250,7 +260,7 @@ struct mhi_channel_config {
>>>   * @irq_moderation_ms: Delay irq for additional events to be 
>>> aggregated
>>>   * @irq: IRQ associated with this ring
>>>   * @channel: Dedicated channel number. U32_MAX indicates a 
>>> non-dedicated ring
>>> - * @priority: Priority of this ring. Use 1 for now
>>> + * @priority: Processing priority of this ring.
>>>   * @mode: Doorbell mode
>>>   * @data_type: Type of data this ring will process
>>>   * @hardware_event: This ring is associated with hardware channels
>>> @@ -262,7 +272,7 @@ struct mhi_event_config {
>>>  	u32 irq_moderation_ms;
>>>  	u32 irq;
>>>  	u32 channel;
>>> -	u32 priority;
>>> +	enum mhi_er_priority priority;
>>>  	enum mhi_db_brst_mode mode;
>>>  	enum mhi_er_data_type data_type;
>>>  	bool hardware_event;
>>> --
>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>> Forum,
>>> a Linux Foundation Collaborative Project
>>> 
> 
> Thanks,
> Bhaumik
> ---
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
> Forum,
> a Linux Foundation Collaborative Project

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
