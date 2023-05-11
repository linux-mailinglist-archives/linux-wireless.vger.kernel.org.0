Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6581D6FF028
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 12:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbjEKKwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjEKKwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 06:52:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4159C4
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 03:52:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f42711865eso30832615e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683802366; x=1686394366;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDBhj27KR354yxCuqIR8nQ0Enpmy7HIOWmEyGFYjPvM=;
        b=vpVG77K+fYQq9IbnIicPnh+6U80NPZc1JkzuK2dYRf2wha68CvWklO5Yb4dBJzECsb
         JbrgJkhQx8hp16p3UFedQLL1yMjJKl6zPibT8acJJHxIemlt/LC8ygzdssPU6dB9AnMZ
         YzHBqCJ3DCVK/hzXqTb/ppnHYmJJ7fxKoa8FkLV8Bsv9Q97QsVfffPY1X6IxdPBJzvio
         6W+VolZYXjuORsxf64TMk+b0QxvXeFuwmtZ8JxJx6rer8F/fFTEPUH9ncpqPj6FriVXj
         OeuTog+8I+3dhk+NtqMqfCu09aM36Gx2JFLlAf/VCGH7jaickNWu2bQ96IFOhA+Cb++j
         r63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802366; x=1686394366;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDBhj27KR354yxCuqIR8nQ0Enpmy7HIOWmEyGFYjPvM=;
        b=ALnSqGip+kmwylrhM5JaULchKjh00LW27Qs1vuuu0xhOjgzjGXCnYNwHZT5ai79vYi
         CIKxZ0rpMjiJu6au2Qkq3s+WNfBH/M9RtVevB+pUKIMq7ukRaIA00/4rpSknIc56dJmB
         J5yBf5KT5OKl93I4eMfM/mnOJaNflxaCvDDbCT0DmJTaC+io7bH+NpPqS2uGQEr2IXxK
         z8DTCTg3wCHuUMizcHwB4svdVR0M4Njzvl8Oggb7nj3Q6VggYPgNYFt0ZiDhMGaXg1gu
         Gx/vSLkw6H+MsFY/Z1X23Ewy4EQUyQFuQGxE4GbD0n0sJhE1AINiAqHIxD7r1UTkDuhs
         SaLw==
X-Gm-Message-State: AC+VfDzNE/x+fEA2s6SxrLyhxxq3TTvj2xQOe4lTSrx/XTxszbeyM//0
        W/SFxSUG2w3arLcFWzJUYOS2sQ==
X-Google-Smtp-Source: ACHHUZ6AK9XHSAZFK8k+X9wtcgdEy9/6iAKy9Y42tWATBZpE2gMXe5wM0YJdpz9OgeVr1CN6CSFxyQ==
X-Received: by 2002:a7b:c843:0:b0:3f4:b6bc:bd80 with SMTP id c3-20020a7bc843000000b003f4b6bcbd80mr3533902wml.33.1683802366342;
        Thu, 11 May 2023 03:52:46 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b00306344eaebfsm20107119wrx.28.2023.05.11.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:52:45 -0700 (PDT)
Date:   Thu, 11 May 2023 13:52:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>,
        johannes@sipsolutions.net
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: Re: [PATCH] cfg80211: S1G rate information and calculations
Message-ID: <468502fa-a43e-4e4c-b00b-cb2af9f7cac1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504024923.1925530-1-gilad.itzkovitch@morsemicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Gilad,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Gilad-Itzkovitch/cfg80211-S1G-rate-information-and-calculations/20230504-105056
base:   28b17f6270f182e22cdad5a0fdc4979031e4486a
patch link:    https://lore.kernel.org/r/20230504024923.1925530-1-gilad.itzkovitch%40morsemicro.com
patch subject: [PATCH] cfg80211: S1G rate information and calculations
config: microblaze-randconfig-m031-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110435.EhEiLYWA-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305110435.EhEiLYWA-lkp@intel.com/

New smatch warnings:
net/wireless/util.c:1744 cfg80211_calculate_bitrate_s1g() error: buffer overflow 'base[idx]' 11 <= 11

vim +1744 net/wireless/util.c

d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1649  static u32 cfg80211_calculate_bitrate_s1g(struct rate_info *rate)
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1650  {
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1651  	/* For 1, 2, 4, 8 and 16 MHz channels */
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1652  	static const u32 base[5][11] = {
                                                                                ^^^^
11 elements.

d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1653  		{  300000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1654  		   600000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1655  		   900000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1656  		  1200000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1657  		  1800000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1658  		  2400000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1659  		  2700000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1660  		  3000000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1661  		  3600000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1662  		  4000000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1663  		  /* MCS 10 supported in 1 MHz only */
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1664  		  150000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1665  		},
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1666  		{  650000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1667  		  1300000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1668  		  1950000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1669  		  2600000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1670  		  3900000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1671  		  5200000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1672  		  5850000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1673  		  6500000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1674  		  7800000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1675  		  /* MCS 9 not valid */
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1676  		},
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1677  		{  1350000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1678  		   2700000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1679  		   4050000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1680  		   5400000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1681  		   8100000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1682  		  10800000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1683  		  12150000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1684  		  13500000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1685  		  16200000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1686  		  18000000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1687  		},
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1688  		{  2925000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1689  		   5850000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1690  		   8775000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1691  		  11700000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1692  		  17550000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1693  		  23400000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1694  		  26325000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1695  		  29250000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1696  		  35100000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1697  		  39000000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1698  		},
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1699  		{  8580000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1700  		  11700000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1701  		  17550000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1702  		  23400000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1703  		  35100000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1704  		  46800000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1705  		  52650000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1706  		  58500000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1707  		  70200000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1708  		  78000000,
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1709  		},
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1710  	};
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1711  	u32 bitrate;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1712  	/* default is 1 MHz index */
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1713  	int idx = 0;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1714  
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1715  	if (rate->mcs > 11)
                                                                      ^^^^
Needs to be >= 11 to prevent off by one.

d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1716  		goto warn;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1717  
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1718  	switch (rate->bw) {
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1719  	case RATE_INFO_BW_16:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1720  		idx = 4;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1721  		break;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1722  	case RATE_INFO_BW_8:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1723  		idx = 3;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1724  		break;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1725  	case RATE_INFO_BW_4:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1726  		idx = 2;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1727  		break;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1728  	case RATE_INFO_BW_2:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1729  		idx = 1;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1730  		break;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1731  	case RATE_INFO_BW_1:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1732  		idx = 0;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1733  		break;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1734  	case RATE_INFO_BW_5:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1735  	case RATE_INFO_BW_10:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1736  	case RATE_INFO_BW_20:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1737  	case RATE_INFO_BW_40:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1738  	case RATE_INFO_BW_80:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1739  	case RATE_INFO_BW_160:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1740  	default:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1741  		goto warn;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1742  	}
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1743  
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04 @1744  	bitrate = base[idx][rate->mcs];
                                                                            ^^^^^^^^^

d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1745  	bitrate *= rate->nss;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1746  
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1747  	if (rate->flags & RATE_INFO_FLAGS_SHORT_GI)
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1748  		bitrate = (bitrate / 9) * 10;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1749  	/* do NOT round down here */
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1750  	return (bitrate + 50000) / 100000;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1751  warn:
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1752  	WARN_ONCE(1, "invalid rate bw=%d, mcs=%d, nss=%d\n",
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1753  		  rate->bw, rate->mcs, rate->nss);
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1754  	return 0;
d973f1b0d4a136 Gilad Itzkovitch     2023-05-04  1755  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

