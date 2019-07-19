Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7636E71E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGSOEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 10:04:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfGSOEu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 10:04:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JE47Zk157192;
        Fri, 19 Jul 2019 14:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=mOGnxW2oeyR7eLgIoEBtNWX4Q3za0clxt09dAtyi8dc=;
 b=ALI4tU3l3h/MtvFiWSa1N6ifdl7pe7r5174pSx4JJtgoiV1DeaT+XXLw1P3nXUSYKRfP
 lbp/h/t2Thc+nvJLvBt2qmK1szgzniHzUecvknFy/5+FA2ZA4u0I7xnMFOFMuSOVxKty
 LL4C8VNVmzspDeGP4B9Hnd1yRAPBhPKEm7Lip1Y/sx17A0UIpTgs2sVUQplPEh1Lm0d9
 4250roVmbhH9Hi/JStYThcbIPFRUqG8RQCCIMqfebyIrM8cpyBMULLZ6LThB8rMZLjfJ
 W4tq6ywgqkYR1Uc3qhG+VV2ScZ9o8t4dBQ31jAgjnzRl/qLM2iNh3y1WINglyiMoLMRD zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qu71m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:04:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JE3jH6031457;
        Fri, 19 Jul 2019 14:04:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tsmcdm5y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:04:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6JE4fK2010649;
        Fri, 19 Jul 2019 14:04:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 14:04:40 +0000
Date:   Fri, 19 Jul 2019 17:04:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay.Kathat@microchip.com
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        gregkh@linuxfoundation.org, hslester96@gmail.com,
        linux-kernel@vger.kernel.org, Adham.Abozaeid@microchip.com
Subject: Re: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to
 get_unaligned_le32
Message-ID: <20190719140429.GI3111@kadam>
References: <20190719081005.4598-1-hslester96@gmail.com>
 <8c14743d-efe1-3e3a-0419-bde22f848751@microchip.com>
 <CANhBUQ3knUV44GiaB-xZMD8F6y8dcZQdznSmpk3E9ZKoakkBRQ@mail.gmail.com>
 <82dc6d2e-5f62-b2c7-296a-38f781628ec5@microchip.com>
 <20190719140133.GH3111@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719140133.GH3111@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190159
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 19, 2019 at 05:01:33PM +0300, Dan Carpenter wrote:
> On Fri, Jul 19, 2019 at 12:05:07PM +0000, Ajay.Kathat@microchip.com wrote:
> > 
> > On 7/19/2019 5:16 PM, Chuhong Yuan wrote:
> > > 
> > > <Ajay.Kathat@microchip.com> 于2019年7月19日周五 下午7:34写道：
> > >>
> > >> On 7/19/2019 1:40 PM, Chuhong Yuan wrote:
> > >>>
> > >>> Merge the combo use of memcpy and le32_to_cpus.
> > >>> Use get_unaligned_le32 instead.
> > >>> This simplifies the code.
> > >>>
> > >>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > >>> ---
> > >>>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
> > >>>  1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> > >>> index d72fdd333050..12fb4add05ec 100644
> > >>> --- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> > >>> +++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> > >>> @@ -1038,8 +1038,7 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
> > >>>       s32 freq;
> > >>>       __le16 fc;
> > >>>
> > >>> -     memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
> > >>> -     le32_to_cpus(&header);
> > >>> +     header = get_unaligned_le32(buff - HOST_HDR_OFFSET);
> > >>>       pkt_offset = GET_PKT_OFFSET(header);
> > >>>
> > >>>       if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
> > >>>
> > >>
> > >> Thanks for sending the patches.
> > >>
> > >> The code change looks okay to me. Just a minor comment, avoid the use of
> > >> same subject line for different patches.
> > > 
> > > These two patches are in the same subsystem and solve the same problem.
> > > I splitted them into two patches by mistake since I did not notice the problems
> > > in the second patch when I sent the first one.
> > > Should I merge the two patches and resend?
> > > 
> > 
> > Yes, please go ahead, merge the patches and send the updated version.
> > 
> 
> This is wrong advice.  Don't merge the patches because they are for
> different drivers.  The original subjects are fine because the
> subsystems are different so that's okay.
> 

Oh...  My bad...  I was looking at the wrong patches.  :P  You are
100% correct Ajay.  Merge the two patches and always make sure to not
send multiple patches with the same subject.

regards,
dan carpenter

