Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64D613453
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 22:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfECUMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 16:12:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfECUMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 16:12:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43JwspL091241;
        Fri, 3 May 2019 20:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=iVW8tYBJhWzHzKQLrG5Z5lw5lDJDgwSzSZaiB4pcjFk=;
 b=WcPqAl6vUBJD7ufPuPj4M7xs97fY1ZufZ4Zm3a2X5dRBgplDfs4FgzU6SN089DVwYdIb
 fwech7bo6pH+V6v+WESyG6Kz7DsX6cOdkdYp8aNRxQVOTSy6kbpRWf4q3IcUX/oCnXqD
 YbRSRg/+8uORh8qCJUtCsOMh0kFiqvnQ3F/dSwa4PYMgDIQMgRo9vyTo0jKE2AYSRU7V
 BDXnUzoz9FEfctJ5r1601/TA9GkLQeNU9PF/IrrF6jO50lOwjOQgu5lw89QQ7zab/KP9
 pkY6tOJ4xlXPbAV6ScqvTNvkLw6MCgqvslLaZKFK3EGu8PKK4DZEUKS6gEeGmTYjMS/P gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2s6xhys0t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 20:12:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43KB8kj010357;
        Fri, 3 May 2019 20:12:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2s6xhhtp46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 20:12:10 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x43KC8hK019195;
        Fri, 3 May 2019 20:12:08 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 13:12:08 -0700
Date:   Fri, 3 May 2019 23:12:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     yhchuang@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw88: new Realtek 802.11ac driver
Message-ID: <20190503201202.GA26955@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030132
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=729 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030132
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Yan-Hsuan Chuang,

The patch e3037485c68e: "rtw88: new Realtek 802.11ac driver" from Apr
26, 2019, leads to the following static checker warning:

	drivers/net/wireless/realtek/rtw88/efuse.c:78 rtw_dump_logical_efuse_map()
	error: buffer overflow 'log_map' 768 <= 768

drivers/net/wireless/realtek/rtw88/efuse.c
    38  static int rtw_dump_logical_efuse_map(struct rtw_dev *rtwdev, u8 *phy_map,
    39                                        u8 *log_map)
    40  {
    41          u32 physical_size = rtwdev->efuse.physical_size;
    42          u32 protect_size = rtwdev->efuse.protect_size;
    43          u32 logical_size = rtwdev->efuse.logical_size;
    44          u32 phy_idx, log_idx;
    45          u8 hdr1, hdr2;
    46          u8 blk_idx;
    47          u8 word_en;
    48          int i;
    49  
    50          for (phy_idx = 0; phy_idx < physical_size - protect_size;) {
    51                  hdr1 = phy_map[phy_idx];
    52                  hdr2 = phy_map[phy_idx + 1];
    53                  if (invalid_efuse_header(hdr1, hdr2))
    54                          break;
    55  
    56                  if ((hdr1 & 0x1f) == 0xf) {
    57                          /* 2-byte header format */
    58                          blk_idx = get_efuse_blk_idx_2_byte(hdr1, hdr2);
    59                          word_en = hdr2 & 0xf;
    60                          phy_idx += 2;
    61                  } else {
    62                          /* 1-byte header format */
    63                          blk_idx = get_efuse_blk_idx_1_byte(hdr1);
    64                          word_en = hdr1 & 0xf;
    65                          phy_idx += 1;
    66                  }
    67  
    68                  for (i = 0; i < 4; i++) {
    69                          if (invalid_efuse_content(word_en, i))
    70                                  continue;
    71  
    72                          log_idx = block_idx_to_logical_idx(blk_idx, i);
    73                          if (phy_idx + 1 > physical_size - protect_size ||
    74                              log_idx + 1 > logical_size)
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a false positive because we know that "log_idx + 1" is an odd
number and logical_size is even so they can't be equal...  But I wonder
if it would make it more readable to change the > to >=?

The log_map[] array has logical_size elements.  It's allocated in
rtw_parse_efuse_map().

    75                                  return -EINVAL;
    76  
    77                          log_map[log_idx] = phy_map[phy_idx];
    78                          log_map[log_idx + 1] = phy_map[phy_idx + 1];
                                ^^^^^^^^^^^^^^^^^^^

    79                          phy_idx += 2;
    80                  }
    81          }
    82          return 0;

regards,
dan carpenter
