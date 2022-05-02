Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2A516D60
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384187AbiEBJcp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380009AbiEBJcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 05:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF233E0D;
        Mon,  2 May 2022 02:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DDF611D0;
        Mon,  2 May 2022 09:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C53C385A4;
        Mon,  2 May 2022 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651483756;
        bh=mpCCh1LYSN/qxfvRph1QMzK0NnMSfrNwVpF7Uzir8sY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UD6zVba96lAU90DevmQSKaqj+6tnduJYu1duIevC0yVgrza7FnZCVYOHDVebEtRAG
         qMRVaCz893bYhRS7MzADwI3RH/+8M/S2I52h1hWJcIEs0iO5PkadPFJcb1ma4OEOf6
         1/kvvXwSyviTE1wNmI6YpLPpF9etI15FSm5OzBUFFwY3B1cYD5+7lkVlHDbxLdP8vc
         Q8Ts3lJWBe5jyTw7oP03C0MNKR30gFVe2kS/1/8HguhpITuiYORr/Coat7U0pVJINX
         kvot+MZwwGUeE+ZIFUF68EqCVzp49tlnLgT+GOJSJ/QBWzU2LvM5g0H0oeHR5D39Va
         66JrDLUAD0Wlg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v7 5/9] ath11k: Fetch device information via QMI for WCN6750
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
        <20220429170502.20080-6-quic_mpubbise@quicinc.com>
Date:   Mon, 02 May 2022 12:29:10 +0300
In-Reply-To: <20220429170502.20080-6-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 29 Apr 2022 22:34:58 +0530")
Message-ID: <87k0b4b7vd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Since WPPS Q6 does the PCIe enumeration of WCN6750, device
> information like BAR and BAR size is not known to the APPS
> processor (Application Processor SubSystem). In order to
> fetch these details, a QMI message called device info request
> will be sent to the target. Therefore, add logic to fetch
> BAR details from the target.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

> +static int ath11k_qmi_request_device_info(struct ath11k_base *ab)
> +{
> +	struct qmi_wlanfw_device_info_req_msg_v01 req = {};
> +	struct qmi_wlanfw_device_info_resp_msg_v01 resp = {};
> +	struct qmi_txn txn;
> +	void __iomem *bar_addr_va;
> +	int ret;
> +
> +	/* device info message req is only sent for hybrid bus devices */
> +	if (!ab->hw_params.hybrid_bus_type)
> +		return 0;
> +
> +	ret = qmi_txn_init(&ab->qmi.handle, &txn,
> +			   qmi_wlfw_device_info_resp_msg_v01_ei, &resp);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
> +			       QMI_WLANFW_DEVICE_INFO_REQ_V01,
> +			       QMI_WLANFW_DEVICE_INFO_REQ_MSG_V01_MAX_LEN,
> +			       qmi_wlanfw_device_info_req_msg_v01_ei, &req);
> +	if (ret < 0) {
> +		qmi_txn_cancel(&txn);
> +		ath11k_warn(ab, "qmi failed to send target device info request, err = %d\n",
> +			    ret);
> +		goto out;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
> +	if (ret < 0) {
> +		ath11k_warn(ab, "qmi failed target device info request %d\n", ret);
> +		goto out;
> +	}
> +
> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
> +		ath11k_warn(ab, "qmi device info req failed, result: %d, err: %d\n",
> +			    resp.resp.result, resp.resp.error);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!resp.bar_addr_valid || !resp.bar_size_valid) {
> +		ath11k_warn(ab, "qmi device info response invalid, result: %d, err: %d\n",
> +			    resp.resp.result, resp.resp.error);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!resp.bar_addr ||
> +	    resp.bar_size != ATH11K_QMI_DEVICE_BAR_SIZE) {
> +		ath11k_warn(ab, "qmi device info invalid addr and size, result: %d, err: %d\n",
> +			    resp.resp.result, resp.resp.error);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	bar_addr_va = devm_ioremap(ab->dev, resp.bar_addr, resp.bar_size);
> +
> +	if (!bar_addr_va) {
> +		ath11k_warn(ab, "qmi device info ioremap failed\n");
> +		ab->mem_len = 0;
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ab->mem = bar_addr_va;
> +	ab->mem_len = resp.bar_size;
> +
> +	return 0;
> +out:
> +	return ret;
> +}

In the pending branch I changed the warning messages to follow the style
used in ath11k.

> +
>  static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
>  {
>  	struct qmi_wlanfw_cap_req_msg_v01 req;
> @@ -2749,6 +2886,12 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
>  		return ret;
>  	}
>  
> +	ret = ath11k_qmi_request_device_info(ab);
> +	if (ret < 0) {
> +		ath11k_warn(ab, "failed to request qmi device info %d\n", ret);
> +		return ret;
> +	}

Here too.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
