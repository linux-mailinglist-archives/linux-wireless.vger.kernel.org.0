Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32466B79D9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 15:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCMOFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCMOEz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 10:04:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF4B34009
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 07:04:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCm5pC008079;
        Mon, 13 Mar 2023 14:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mcKRsI6pbjp8EN5nqL+p9o0tf6nZAK32B/3a5SquJHM=;
 b=CjRPjuYYehS7T4tevupF5Ha8SHA2sFSO/CL8jKL6PFNebf1pQrj+BSkD5OXovliNT+2C
 1iOMO8SFecfDKTYkyVN/CKM7rq0Dx+iALQAuB2ReQonPKzWpj07gCNYCxwbKgGHoKlo0
 K5Hsib4smOO2Dm0w9qocz+OHjUZLtKoykIvNlPiropZwiFZAOJVJuiCW44mGtLsd4aRN
 UND+FRV6dbEhrolg5Q3njGwkr5WK0ukkaqQ372HV6E5/Xsjrj98USNppxIU8NTgTntp+
 1BhfhpWg8/A2ExvMxLf6Wu0QV3Jg2x95RwKdbp9UUlYtjdsWc8E+n4yu7G95+nG7fhCf 6Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa44br7fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:04:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32DE4eIM015358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:04:40 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 07:04:39 -0700
Message-ID: <e1b72b60-cefb-a4b1-2784-9e72df71060e@quicinc.com>
Date:   Mon, 13 Mar 2023 08:04:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] mhi: allow MHI client drivers to provide the firmware
 via a pointer
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <mhi@lists.linux.dev>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20230111092547.21425-1-kvalo@kernel.org>
 <20230111092547.21425-2-kvalo@kernel.org>
 <7d692402-3fc1-3b4c-9697-25e722e94539@quicinc.com>
 <87bkn4ds9y.fsf@kernel.org> <87bkl3peg7.fsf@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <87bkl3peg7.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a_3wuEyIaYc9hjpsGdffOfyeWhb4vUhE
X-Proofpoint-ORIG-GUID: a_3wuEyIaYc9hjpsGdffOfyeWhb4vUhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_07,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=816 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/8/2023 6:20 AM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Jeffrey Hugo <quic_jhugo@quicinc.com> writes:
>>
>>> On 1/11/2023 2:25 AM, Kalle Valo wrote:
>>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>>
>>>> Currently MHI loads the firmware image from the path provided by client
>>>> devices. ath11k needs to support firmware image embedded along with meta data
>>>> (named as firmware-2.bin). So allow the client driver to request the firmware
>>>> file from user space on it's own and provide the firmware image data and size
>>>> to MHI via a pointer struct mhi_controller::fw_data.
>>>>
>>>> This is an optional feature, if fw_data is NULL MHI load the firmware using the
>>>> name from struct mhi_controller::fw_image string as before.
>>>>
>>>> Tested with ath11k and WCN6855 hw2.0.
>>>>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> [...]
> 
>>> Did you run pahole?  I remember this struct being well packed, and I
>>> think this will add a compiler hole but I have not actually verified.
>>
>> I actually haven't used pahole for ages. I will run it and check how
>> this structure is packed.
> 
> Below is what pahole shows with GCC 8.3 on x86_64. Look pretty well
> packed, right?

Yes, looks almost perfect.

> 
> struct mhi_controller {
> 	struct device *            cntrl_dev;            /*     0     8 */
> 	struct mhi_device *        mhi_dev;              /*     8     8 */
> 	struct dentry *            debugfs_dentry;       /*    16     8 */
> 	void *                     regs;                 /*    24     8 */
> 	void *                     bhi;                  /*    32     8 */
> 	void *                     bhie;                 /*    40     8 */
> 	void *                     wake_db;              /*    48     8 */
> 	dma_addr_t                 iova_start;           /*    56     8 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	dma_addr_t                 iova_stop;            /*    64     8 */
> 	const char  *              fw_image;             /*    72     8 */
> 	const u8  *                fw_data;              /*    80     8 */
> 	size_t                     fw_sz;                /*    88     8 */
> 	const char  *              edl_image;            /*    96     8 */
> 	size_t                     rddm_size;            /*   104     8 */
> 	size_t                     sbl_size;             /*   112     8 */
> 	size_t                     seg_len;              /*   120     8 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	size_t                     reg_len;              /*   128     8 */
> 	struct image_info *        fbc_image;            /*   136     8 */
> 	struct image_info *        rddm_image;           /*   144     8 */
> 	struct mhi_chan *          mhi_chan;             /*   152     8 */
> 	struct list_head           lpm_chans;            /*   160    16 */
> 	int *                      irq;                  /*   176     8 */
> 	u32                        max_chan;             /*   184     4 */
> 	u32                        total_ev_rings;       /*   188     4 */
> 	/* --- cacheline 3 boundary (192 bytes) --- */
> 	u32                        hw_ev_rings;          /*   192     4 */
> 	u32                        sw_ev_rings;          /*   196     4 */
> 	u32                        nr_irqs;              /*   200     4 */
> 	u32                        family_number;        /*   204     4 */
> 	u32                        device_number;        /*   208     4 */
> 	u32                        major_version;        /*   212     4 */
> 	u32                        minor_version;        /*   216     4 */
> 	u32                        serial_number;        /*   220     4 */
> 	u32                        oem_pk_hash[16];      /*   224    64 */
> 	/* --- cacheline 4 boundary (256 bytes) was 32 bytes ago --- */
> 	struct mhi_event *         mhi_event;            /*   288     8 */
> 	struct mhi_cmd *           mhi_cmd;              /*   296     8 */
> 	struct mhi_ctxt *          mhi_ctxt;             /*   304     8 */
> 	struct mutex               pm_mutex;             /*   312   160 */
> 	/* --- cacheline 7 boundary (448 bytes) was 24 bytes ago --- */
> 	rwlock_t                   pm_lock;              /*   472    72 */
> 	/* --- cacheline 8 boundary (512 bytes) was 32 bytes ago --- */
> 	u32                        timeout_ms;           /*   544     4 */
> 	u32                        pm_state;             /*   548     4 */
> 	u32                        db_access;            /*   552     4 */
> 	enum mhi_ee_type           ee;                   /*   556     4 */
> 	enum mhi_state             dev_state;            /*   560     4 */
> 	atomic_t                   dev_wake;             /*   564     4 */
> 	atomic_t                   pending_pkts;         /*   568     4 */
> 	u32                        M0;                   /*   572     4 */
> 	/* --- cacheline 9 boundary (576 bytes) --- */
> 	u32                        M2;                   /*   576     4 */
> 	u32                        M3;                   /*   580     4 */
> 	struct list_head           transition_list;      /*   584    16 */
> 	spinlock_t                 transition_lock;      /*   600    72 */
> 	/* --- cacheline 10 boundary (640 bytes) was 32 bytes ago --- */
> 	spinlock_t                 wlock;                /*   672    72 */
> 	/* --- cacheline 11 boundary (704 bytes) was 40 bytes ago --- */
> 	struct mhi_link_info       mhi_link_info;        /*   744     8 */
> 	struct work_struct         st_worker;            /*   752    80 */
> 	/* --- cacheline 13 boundary (832 bytes) --- */
> 	struct workqueue_struct *  hiprio_wq;            /*   832     8 */
> 	wait_queue_head_t          state_event;          /*   840    88 */
> 	/* --- cacheline 14 boundary (896 bytes) was 32 bytes ago --- */
> 	void                       (*status_cb)(struct mhi_controller *, enum mhi_callback); /*   928     8 */
> 	void                       (*wake_get)(struct mhi_controller *, bool); /*   936     8 */
> 	void                       (*wake_put)(struct mhi_controller *, bool); /*   944     8 */
> 	void                       (*wake_toggle)(struct mhi_controller *); /*   952     8 */
> 	/* --- cacheline 15 boundary (960 bytes) --- */
> 	int                        (*runtime_get)(struct mhi_controller *); /*   960     8 */
> 	void                       (*runtime_put)(struct mhi_controller *); /*   968     8 */
> 	int                        (*map_single)(struct mhi_controller *, struct mhi_buf_info *); /*   976     8 */
> 	void                       (*unmap_single)(struct mhi_controller *, struct mhi_buf_info *); /*   984     8 */
> 	int                        (*read_reg)(struct mhi_controller *, void *, u32 *); /*   992     8 */
> 	void                       (*write_reg)(struct mhi_controller *, void *, u32); /*  1000     8 */
> 	void                       (*reset)(struct mhi_controller *); /*  1008     8 */
> 	size_t                     buffer_len;           /*  1016     8 */
> 	/* --- cacheline 16 boundary (1024 bytes) --- */
> 	int                        index;                /*  1024     4 */
> 	bool                       bounce_buf;           /*  1028     1 */
> 	bool                       fbc_download;         /*  1029     1 */
> 	bool                       wake_set;             /*  1030     1 */
> 
> 	/* XXX 1 byte hole, try to pack */
> 
> 	long unsigned int          irq_flags;            /*  1032     8 */
> 	u32                        mru;                  /*  1040     4 */
> 
> 	/* size: 1048, cachelines: 17, members: 73 */
> 	/* sum members: 1043, holes: 1, sum holes: 1 */
> 	/* padding: 4 */
> 	/* last cacheline: 24 bytes */
> };
> 

