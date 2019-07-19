Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC06E716
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfGSOBs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 10:01:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSOBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 10:01:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JDn8n3038121;
        Fri, 19 Jul 2019 14:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=X6wMOR1hKPNrM0QQ+tB1C00yfQWcVs6T/NvRGy8Eo0w=;
 b=4boiRN5EskaJGCZJZwbA5uooIUSUUYV0YaFnXGMZULf6c7WkT3yDfe6rFKqghS7OijA9
 hJs3ENN8rCoFFjArc6DQSVIGYYPTnOAod6otGZF0Yifu2m0Ax5E7xxFf4cVmQuY6V+9f
 6T3o8KH+FfcpNzQ7xKwkvWNwhlJuq57xfPx91TRYpHx/9xL/YOxluszGLh7n+AOv6t74
 uG9Ae8Er1cWeTuH4QMRWi1/GmentqGJYi1WvjmDCLpGwKSh+39zsG7nB3xtOi7xyEweN
 hmsEjLYcLLzrGx0p6z+ZEu810DCpKJAHPJxp86spUx3eQySaag4uY4aeHszSSCTb6eQP hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78q6vq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:01:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JDmHrb189259;
        Fri, 19 Jul 2019 14:01:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tsmcdm420-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:01:41 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6JE1eFI008791;
        Fri, 19 Jul 2019 14:01:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 14:01:39 +0000
Date:   Fri, 19 Jul 2019 17:01:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay.Kathat@microchip.com
Cc:     hslester96@gmail.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adham.Abozaeid@microchip.com
Subject: Re: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to
 get_unaligned_le32
Message-ID: <20190719140133.GH3111@kadam>
References: <20190719081005.4598-1-hslester96@gmail.com>
 <8c14743d-efe1-3e3a-0419-bde22f848751@microchip.com>
 <CANhBUQ3knUV44GiaB-xZMD8F6y8dcZQdznSmpk3E9ZKoakkBRQ@mail.gmail.com>
 <82dc6d2e-5f62-b2c7-296a-38f781628ec5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82dc6d2e-5f62-b2c7-296a-38f781628ec5@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190158
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 19, 2019 at 12:05:07PM +0000, Ajay.Kathat@microchip.com wrote:
> 
> On 7/19/2019 5:16 PM, Chuhong Yuan wrote:
> > 
> > <Ajay.Kathat@microchip.com> 于2019年7月19日周五 下午7:34写道：
> >>
> >> On 7/19/2019 1:40 PM, Chuhong Yuan wrote:
> >>>
> >>> Merge the combo use of memcpy and le32_to_cpus.
> >>> Use get_unaligned_le32 instead.
> >>> This simplifies the code.
> >>>
> >>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> >>> ---
> >>>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
> >>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> >>> index d72fdd333050..12fb4add05ec 100644
> >>> --- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> >>> +++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> >>> @@ -1038,8 +1038,7 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
> >>>       s32 freq;
> >>>       __le16 fc;
> >>>
> >>> -     memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
> >>> -     le32_to_cpus(&header);
> >>> +     header = get_unaligned_le32(buff - HOST_HDR_OFFSET);
> >>>       pkt_offset = GET_PKT_OFFSET(header);
> >>>
> >>>       if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
> >>>
> >>
> >> Thanks for sending the patches.
> >>
> >> The code change looks okay to me. Just a minor comment, avoid the use of
> >> same subject line for different patches.
> > 
> > These two patches are in the same subsystem and solve the same problem.
> > I splitted them into two patches by mistake since I did not notice the problems
> > in the second patch when I sent the first one.
> > Should I merge the two patches and resend?
> > 
> 
> Yes, please go ahead, merge the patches and send the updated version.
> 

This is wrong advice.  Don't merge the patches because they are for
different drivers.  The original subjects are fine because the
subsystems are different so that's okay.

regards,
dan carpenter

