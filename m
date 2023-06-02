Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0B72083C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjFBRRm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjFBRRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 13:17:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888F1A7
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 10:17:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CsuID026594;
        Fri, 2 Jun 2023 17:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P8kyodF2jzzYpDdKzUjvz7vqif2Wp2TMDpY8lTBod4I=;
 b=R5MJsUKWhOn57dozDKyCqGTWVfua8y0bMUZYdTPP3eQXa1msh/e8zfms9b9H0I1aNbif
 OQnn3mK95CzxuStiKocWhw3iem1oZeDiadJBaQ3S1MKsK/mWzHLIWUoxYCPNOa0alPEI
 DqfSVnWyhuwPqOESrPdhgLqx1H0kS7zZTEELopPtlme+gZubZM6nfO2Y9M0GIKiu6V7S
 aClWVqQoFbFzWP6AAyhkUEEuZgsz15x6b12AmdK8VP05eGKDs0QuM31mbYRqMhLB3MSC
 +7PweVM/l85cJPBNe2kTra6B+lSIJIVyVqMJXhm3wiDiVIzwUoT0phwyjhloP/oOF0IK Pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy1bcjbab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 17:17:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352HHNQT005274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 17:17:23 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 2 Jun 2023
 10:17:22 -0700
Message-ID: <6494e9f5-a4df-c058-49bb-1ebfeca5a91d@quicinc.com>
Date:   Fri, 2 Jun 2023 11:17:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/3] bus: mhi: host: allow MHI client drivers to
 provide the firmware via a pointer
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230530141813.29333-1-kvalo@kernel.org>
 <20230530141813.29333-2-kvalo@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230530141813.29333-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lOK129aB9OipqPTAAAGtNBeu9PcWq32J
X-Proofpoint-GUID: lOK129aB9OipqPTAAAGtNBeu9PcWq32J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_13,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020131
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/30/2023 8:18 AM, Kalle Valo wrote:
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
>   drivers/bus/mhi/host/boot.c | 34 +++++++++++++++++++++++++---------
>   include/linux/mhi.h         |  6 ++++++
>   2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index d2a19b07ccb8..edc0ec5a0933 100644
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
> @@ -393,9 +391,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	enum mhi_pm_state new_state;
>   	const char *fw_name;
> +	const u8 *fw_data;
>   	void *buf;
>   	dma_addr_t dma_addr;
> -	size_t size;
> +	size_t size, fw_sz;
>   	int i, ret;
>   
>   	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
> @@ -425,6 +424,20 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
>   		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
>   
> +	/* check if the driver has already provided the firmware data */
> +	if (!fw_name && mhi_cntrl->fbc_download &&
> +	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
> +		if (!mhi_cntrl->sbl_size) {
> +			dev_err(dev, "fw_data provided but no sbl_size\n");
> +			goto error_fw_load;
> +		}
> +
> +		size = mhi_cntrl->sbl_size;
> +		fw_data = mhi_cntrl->fw_data;
> +		fw_sz = mhi_cntrl->fw_sz;
> +		goto skip_req_fw;
> +	}
> +
>   	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
>   						     !mhi_cntrl->seg_len))) {
>   		dev_err(dev,
> @@ -444,6 +457,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
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
> @@ -452,7 +469,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	}
>   
>   	/* Download image using BHI */
> -	memcpy(buf, firmware->data, size);
> +	memcpy(buf, fw_data, size);
>   	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
>   	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
>   
> @@ -464,7 +481,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	}
>   
>   	/* Wait for ready since EDL image was loaded */
> -	if (fw_name == mhi_cntrl->edl_image) {
> +	if (fw_name && fw_name == mhi_cntrl->edl_image) {
>   		release_firmware(firmware);
>   		goto fw_load_ready_state;
>   	}
> @@ -478,15 +495,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	 * device transitioning into MHI READY state
>   	 */
>   	if (mhi_cntrl->fbc_download) {
> -		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
> -					   firmware->size);
> +		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
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
> index f6de4b6ecfc7..7bd58fcb7e58 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -299,6 +299,10 @@ struct mhi_controller_config {
>    * @iova_start: IOMMU starting address for data (required)
>    * @iova_stop: IOMMU stop address for data (required)
>    * @fw_image: Firmware image name for normal booting (optional)
> + * @fw_data: Firmware image data content for normal booting, used only
> + *           if fw_image is NULL (optional)

It looks like your implementation requires fbc_download to be set, and 
while you mention that for fw_sz, you don't mention it here.  While I 
think this would be useful for non-fbc usecases, we don't have that use 
currently.

I think documenting the fbc_download requirement and letting the usecase 
that needs this for non-fbc extend it is reasonable.

With this,
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

> + * @fw_sz: Firmware image data size for normal booting, used only if fw_image
> + *         is NULL and fbc_download is true (optional)
>    * @edl_image: Firmware image name for emergency download mode (optional)
>    * @rddm_size: RAM dump size that host should allocate for debugging purpose
>    * @sbl_size: SBL image size downloaded through BHIe (optional)
> @@ -384,6 +388,8 @@ struct mhi_controller {
>   	dma_addr_t iova_start;
>   	dma_addr_t iova_stop;
>   	const char *fw_image;
> +	const u8 *fw_data;
> +	size_t fw_sz;
>   	const char *edl_image;
>   	size_t rddm_size;
>   	size_t sbl_size;

