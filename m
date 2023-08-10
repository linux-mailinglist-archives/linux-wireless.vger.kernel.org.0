Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9E777EF5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjHJRTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjHJRTP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 13:19:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B22C26BD;
        Thu, 10 Aug 2023 10:19:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so241534266b.0;
        Thu, 10 Aug 2023 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691687954; x=1692292754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa4B+1a65dQ6pp535Suh0RpK8subM4aWiX4LFqYd1nc=;
        b=Sl4zlYhoRgpk19oNmOq9ZWSimGiGcCZABSUw8RUdKmEODJ6btKHLXIljdgyKLY8Vkv
         dNzcT48Mj/NQqYF0vOWJ9sqzxZcqpmEhk90Bd5Ko+y2a8gZCtV4yblqJOUKEmk/wSNaV
         OQcH4JlQRmtAhX3GGcjMXqdeBbR8W7PR9+vEQFMDOIkygRexQDLt95MHjXAbYzJPYVeG
         oPrywmFcqPDMcDJwnm/E28gUAe0GLAArVSNwhRWWCa+xyW0XtxJKZP+a+r5Ov6xFsvfF
         uBPZZ4z9+xAoxXCe5265b+oFfdtALZHdkY7fdoUsgo82dQyf3uJ3drdtFDVf/aveckMI
         XStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691687954; x=1692292754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa4B+1a65dQ6pp535Suh0RpK8subM4aWiX4LFqYd1nc=;
        b=IHjV9x7Ph+FtevO2c+BTDSwUcDFDGnUf7LzigrOQ/CUU0bPBDs9JKN+oMzek+/E9Lf
         yI0HrX6KamF4rK/cX4Gc9cXra7P+2PiUcpPaPWdeajyPm+Cvz60PjT22A5oXCkrtS00h
         JbScQLeshusx4CXEsnunHXxkxSDFieMjAGIe8csJZ99bFccCsNQMLo7/7GTqqeSN2gEG
         xU/xINOcpFSkDhU0GKdIxooGb8uCt8YbpikDgwh9BTFsB20BPOul3T8gyxknc0yHFJY/
         G3aogyLlE61MkUoveNopcHJs0T9Ak4h0xBqZbi3ww2IjaWkJVUqKUWAvnef9LlJMk6Vg
         ydow==
X-Gm-Message-State: AOJu0YzYiqWF71xqbq3xRz3MEHBlIJgYUbwP+fkr9Qb6gj95/t5nMmiJ
        nwODfmc+ecY2RdNZzEeAo1o=
X-Google-Smtp-Source: AGHT+IFRdXs2EHk3/qqyal85mpIldj6sYZeDrJv+54CHbW9FX89UJY0hIAEORRYaLpqwdLmMml7oPA==
X-Received: by 2002:a17:906:5397:b0:99c:5056:4e31 with SMTP id g23-20020a170906539700b0099c50564e31mr3620995ejo.15.1691687953670;
        Thu, 10 Aug 2023 10:19:13 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906278f00b009926928d486sm1193668ejc.35.2023.08.10.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:19:13 -0700 (PDT)
Date:   Thu, 10 Aug 2023 20:19:10 +0300
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
Subject: Re: [PATCH net-next v2 1/5] net: dsa: realtek: Remove redundant
 of_match_ptr()
Message-ID: <20230810171910.w2ruvj4sbcu6dlsz@skbuf>
References: <20230810081656.2981965-1-ruanjinjie@huawei.com>
 <20230810081656.2981965-2-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810081656.2981965-2-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 04:16:52PM +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
