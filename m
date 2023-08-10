Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEE777EFA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjHJRTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHJRTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 13:19:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678602704;
        Thu, 10 Aug 2023 10:19:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso1774377e87.3;
        Thu, 10 Aug 2023 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691687990; x=1692292790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glU5erJjBqNMtllqlB9ihZqDejep906URnvDobpiPsI=;
        b=svntvc4urjFEnCCJTktgo5IZ2cmplKnCz53w0PNSjw4pud8VtXzg+BZk7rnca4KTXk
         EDbAnH/4QhTJleTjdH3Sf3s2mBUSX6Ju9M0xedC9YiUCd4j9CtvjVNzdFpdX3CE9rb/u
         XK0xIjGaHv/dwrRYLaS/4n6bO4SgJ/RuDKF5tYX+AvowOLA8fwekv8rqRtLrpodP4CIF
         /1OqeEI6FWyoCSUV5j5QpbXu10LCiuiV0ZIgWCluY7kpJPCjTWTWJV0zHlWnQSGk2SYS
         3phclGBEvA59iAC1cednC8bg+aXkIrfhQeHRxVnyl9LWmNaVpSKAhr4i1XqACvXGQo+c
         v61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691687990; x=1692292790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glU5erJjBqNMtllqlB9ihZqDejep906URnvDobpiPsI=;
        b=XrufHYVF3AeLZPFmk291lzK4TxoGH1PPO4Gr9uJ9/vT/ku3gvX87UZr13c/0Cmgj+Q
         dUmW9T/G5uYLqhB1PZ/IOWRv7ktxfk/gyUFkcsUMvIvyZMlTTSjmLX2MB7xvFEUVL5zl
         cMbeeoMxMBNtLxkkLqC5LB6WZ8KX3DXaGo3W5b6YtLwDITLJPAR+37gCSxAq3Jf9qC3y
         it4cs0NZQJITXoBgkxNV7LmwuhRMPTQu9/Og1BX/7jHaR1ijGJhVGA56IRHdoxjtuOay
         pF989cePdgZ06jMgwxxYjzb+O+Kt6FxpUmchR6OJR5vFJrLqTSkM0OJTPucmrQ9iZ6wn
         2Mww==
X-Gm-Message-State: AOJu0YyzrLjRk+ZImYWGEUBCwITKwKVgYa4mRTAR0acR5rk1jUy6tVje
        dbIdrSxsSM0Fyh77U+Xee9c=
X-Google-Smtp-Source: AGHT+IGdyO2tn0HWaqLZ0pGpRKSfpvf3CvCR2AHOfQRI1hi4J8rGnxb1L2u1I2vPEVy0qoh+ZFzpCw==
X-Received: by 2002:a05:6512:a95:b0:4f4:d071:be48 with SMTP id m21-20020a0565120a9500b004f4d071be48mr3192837lfu.14.1691687990349;
        Thu, 10 Aug 2023 10:19:50 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402028900b0052337ff078bsm1028943edv.92.2023.08.10.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:19:50 -0700 (PDT)
Date:   Thu, 10 Aug 2023 20:19:47 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, clement.leger@bootlin.com,
        ulli.kroll@googlemail.com, kvalo@kernel.org,
        bhupesh.sharma@linaro.org, robh@kernel.org, elder@linaro.org,
        wei.fang@nxp.com, nicolas.ferre@microchip.com,
        simon.horman@corigine.com, romieu@fr.zoreil.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: dsa: rzn1-a5psw: Remove redundant
 of_match_ptr()
Message-ID: <20230810171947.ekvebzyjuccvdmef@skbuf>
References: <20230810081656.2981965-1-ruanjinjie@huawei.com>
 <20230810081656.2981965-3-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810081656.2981965-3-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 04:16:53PM +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
