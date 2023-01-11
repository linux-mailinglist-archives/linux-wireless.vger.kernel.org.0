Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960D3665EF8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 16:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjAKPUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 10:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjAKPUw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 10:20:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BBFCE9
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 07:20:50 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BDSZxW009906;
        Wed, 11 Jan 2023 15:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/YvBClGX/zmnvgpUhJlAbnaIFEHh8kuj/QmimjZlJVQ=;
 b=inIFMVHoHpNTCEfh/wxSElz80IpwzPvExgVeHgU8tTolg92Ar0hGjGlPVoI+bjOzFhV+
 PnDABswuvCIlrCqa8bQ3T9UHiUCU7dX2mvspo6q8PAB85abjocjFVhXb5gWuZnzx8GnE
 SELtV1D19p93ecyzidUdt3iUaQb8a8afGuw8XOYG3AePP8GqM5kfmxxfChOzSRQmkJzI
 5oTAhrz0xeNSjsYqc4sS1uqSNUtBWVzZdW0X+RkKQW0UE8q65CKcZ4hfxj+P/BlFnVcJ
 SCSzwqIvX8AgL0Aw2j6D57LT1c6kAlKWb2VJAghY54dJFW7iuZ9NRd3WT5wVluMIbGCc 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k9j1kct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:20:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BFKa4c006670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:20:36 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 07:20:35 -0800
Message-ID: <7d692402-3fc1-3b4c-9697-25e722e94539@quicinc.com>
Date:   Wed, 11 Jan 2023 08:20:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] mhi: allow MHI client drivers to provide the firmware
 via a pointer
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230111092547.21425-1-kvalo@kernel.org>
 <20230111092547.21425-2-kvalo@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230111092547.21425-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bLQ0-FWqS3L6vY3jUhzMrUFMm8iU8d26
X-Proofpoint-ORIG-GUID: bLQ0-FWqS3L6vY3jUhzMrUFMm8iU8d26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/11/2023 2:25 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Currently MHI loads the firmware image from the path provided by client
> devices. ath11k needs to support firmware image embedded along with meta data
> (named as firmware-2.bin). So allow the client driver to request the firmware
> file from user space on it's own and provide the firmware image data and size
> to MHI via a pointer struct mhi_controller::fw_data.
> 
> This is an optional feature, if fw_data is NULL MHI load the firmware using the
> name from struct mhi_controller::fw_image string as before.
> 
> Tested with ath11k and WCN6855 hw2.0.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/bus/mhi/host/boot.c | 27 +++++++++++++++++++--------
>   include/linux/mhi.h         |  6 ++++++
>   2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 1c69feee1703..d6d5f424491e 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -365,12 +365,10 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
>   }
>   
>   static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
> -			      const struct firmware *firmware,
> +			      const u8 *buf, size_t remainder,
>   			      struct image_info *img_info)
>   {
> -	size_t remainder = firmware->size;
>   	size_t to_cpy;
> -	const u8 *buf = firmware->data;
>   	struct mhi_buf *mhi_buf = img_info->mhi_buf;
>   	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
>   
> @@ -392,9 +390,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	const struct firmware *firmware = NULL;
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	const char *fw_name;
> +	const u8 *fw_data;
>   	void *buf;
>   	dma_addr_t dma_addr;
> -	size_t size;
> +	size_t size, fw_sz;
>   	int i, ret;
>   
>   	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
> @@ -424,6 +423,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
>   		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
>   
> +	if (!fw_name && mhi_cntrl->fbc_download &&
> +	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
> +		size = mhi_cntrl->sbl_size;
> +		fw_data = mhi_cntrl->fw_data;
> +		fw_sz = mhi_cntrl->fw_sz;
> +		goto skip_req_fw;
> +	}
> +
>   	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
>   						     !mhi_cntrl->seg_len))) {
>   		dev_err(dev,
> @@ -443,6 +450,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	if (size > firmware->size)
>   		size = firmware->size;
>   
> +	fw_data = firmware->data;
> +	fw_sz = firmware->size;
> +
> +skip_req_fw:
>   	buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, &dma_addr,
>   				 GFP_KERNEL);
>   	if (!buf) {
> @@ -451,7 +462,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	}
>   
>   	/* Download image using BHI */
> -	memcpy(buf, firmware->data, size);
> +	memcpy(buf, fw_data, size);
>   	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
>   	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
>   
> @@ -463,7 +474,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	}
>   
>   	/* Wait for ready since EDL image was loaded */
> -	if (fw_name == mhi_cntrl->edl_image) {
> +	if (fw_name && fw_name == mhi_cntrl->edl_image) {
>   		release_firmware(firmware);
>   		goto fw_load_ready_state;
>   	}
> @@ -478,14 +489,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	 */
>   	if (mhi_cntrl->fbc_download) {
>   		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
> -					   firmware->size);
> +					   fw_sz);

Minor nit, but it seems like this could be all on one line.

>   		if (ret) {
>   			release_firmware(firmware);
>   			goto error_fw_load;
>   		}
>   
>   		/* Load the firmware into BHIE vec table */
> -		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
> +		mhi_firmware_copy(mhi_cntrl, fw_data, fw_sz, mhi_cntrl->fbc_image);
>   	}
>   
>   	release_firmware(firmware);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index a5441ad33c74..0d11fe22633e 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -299,6 +299,10 @@ struct mhi_controller_config {
>    * @iova_start: IOMMU starting address for data (required)
>    * @iova_stop: IOMMU stop address for data (required)
>    * @fw_image: Firmware image name for normal booting (optional)
> + * @fw_data: Firmware image data content for normal booting, used only
> + *           if fw_image is NULL (optional)

The implementation requires fbc_download to be set, which is not a 
requirement for fw_image.  That is not apparent here.

> + * @fw_sz: Firmware image data size for normal booting, used only if fw_image
> + *         is NULL (optional)
>    * @edl_image: Firmware image name for emergency download mode (optional)
>    * @rddm_size: RAM dump size that host should allocate for debugging purpose
>    * @sbl_size: SBL image size downloaded through BHIe (optional)
> @@ -384,6 +388,8 @@ struct mhi_controller {
>   	dma_addr_t iova_start;
>   	dma_addr_t iova_stop;
>   	const char *fw_image;
> +	const u8 *fw_data;
> +	size_t fw_sz;

Did you run pahole?  I remember this struct being well packed, and I 
think this will add a compiler hole but I have not actually verified.

>   	const char *edl_image;
>   	size_t rddm_size;
>   	size_t sbl_size;

