Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC15B51DDD2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443865AbiEFQvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbiEFQv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 12:51:29 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 09:47:45 PDT
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938714551C
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 09:47:45 -0700 (PDT)
Received: from [192.168.1.139] ([151.63.193.237])
        by smtp-33.iol.local with ESMTPA
        id n16GnuioLtMz4n16Gnf020; Fri, 06 May 2022 18:46:41 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1651855601; bh=HLROkVXLV44iGMLomM52zu+3+VdWaSk1N62px9xHxIE=;
        h=From;
        b=u/ZHlvPa3QXeRHSMo9ZYQIRH5oEBp28Vb89H/3cU+uKW9errGgwMGFKx7MeZXL0sN
         y9VMbzxuQmBeWjrmZsg9CuBUkfhkzl61PyxSPXaxu+9FcJbY01RnS8+ERa34ek4rr7
         QDzz4D4RUWNsaNOikonHc4GyMHZAQidneMvUnnZxYPSJGpLv5tOzZq0pn9C0zhMTHT
         tsyl/IFY8kdE+1uUpuJMXG5wiRnPA8x6gFPexfSnzM3+LmGzOgYv1FdgFlHPoI07QV
         wom9ztiQd+2ZiiFs4fWzjFAtf9f4B1811PNRxHFwtP6Mi4jZtUtuNjDlFtHODzkrt6
         H9y5PBpZqMQPg==
X-CNFS-Analysis: v=2.4 cv=RvwAkAqK c=1 sm=1 tr=0 ts=627550f1 cx=a_exe
 a=pRqCBjLYe1/oAQLR8T0ftA==:117 a=pRqCBjLYe1/oAQLR8T0ftA==:17
 a=IkcTkHD0fZMA:10 a=mMPbqnc4dKjPPDpq_UIA:9 a=QEXdDO2ut3YA:10
Message-ID: <12fa1e40-cca9-ba55-f589-c08f902ba863@libero.it>
Date:   Fri, 6 May 2022 18:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org, tony0620emma@gmail.com,
        willyangywt@gmail.com
References: <a68ffbe845ad4867a0b14c811b2c5fbf@realtek.com>
Subject: RE: rtw8822ce: support for miracast?
Content-Language: en-US
From:   Alessandro <a.geno@libero.it>
In-Reply-To: <a68ffbe845ad4867a0b14c811b2c5fbf@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGnbT7RgdMLLydr2ck0106LwQD1WZLnHRqdvAjvUtGMOREuv7nJoZyEUfAUMWtOePsIvina+VxPXWtctCOZ5ghk13Y7BdGSHabbD5vjCKScMf+WSV7s9
 QWs5JceuDkZogabl87jldkVMDZlKeiVUk/qeOxqoDKnTkTe4hW1aHCG8x5Seyjy/b+4HOPa/aus/XTMgSN4jTDSSSyUt/zveASOw99Nsojrim4hr3RzGz77r
 TYPuIVKheeYqZL1FBV+u+2+niKOkj3ydFFUABxh0ZcTy/eBHSGe8kErvrXBs9jXJ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi. I'd like it to be supported too.


On Windows I am able to cast, but not on Linux. The driver does not 
support P2P

