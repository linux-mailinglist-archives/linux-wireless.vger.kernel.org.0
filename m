Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE475D7D1
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jul 2023 01:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGUXHt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 19:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGUXHs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 19:07:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0FF0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 16:07:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bb0cadd3ccso1356788a34.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 16:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689980866; x=1690585666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elgJU4KYXnMU4elu+VWtZiXEvECTg2Czc+aEZpm934k=;
        b=GR/qfrPtrl3E60huygGbxqHchOVMW0l4uNKW2wEKq91ORQRuUPn3h6c8jAUP8uJ3Mg
         ZgZTq1icVE5NXLyzvQcg2XWQcU/nNooUwpCLGA96oyBiktsiSIioVGVXxE5cmEmzm1X+
         Nh5kypgUE3uepME3vqa5cVTm/bbmluyTc5rKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689980866; x=1690585666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elgJU4KYXnMU4elu+VWtZiXEvECTg2Czc+aEZpm934k=;
        b=Yj1dQATUdcarLsdNG85d+sXiPL+lZhkE7RUJYbkmPTuqvY/kdTo6cQpFhHwAZHTt7T
         LytCIuwja5zmqfNlhLDxdvpFruWtOUH4YUOlnNPkzOMm0PfotiHFnccCVY/xuJdcMj7O
         6PcU3JteK6asZEQESpSmztALgQUBJlK0KqsEZIjinbzk5gvJs8PC6czR2J9snlMbhcgi
         kxtTx5Qf2SZRaGEhGEjy25e4O7CWlJR9EE5abKmRawOZZqMFEt32X8gB6v+cfVscQvvS
         4cOKXt6JcNlw5cjgRHmsU2osVJB8kyGQg4/N2XBSMuKihgA9XaIavZRPrMC9os/R+IyD
         ryDA==
X-Gm-Message-State: ABy/qLbEBU4VBjJiIPE/QN5X5dQZMihc+T2tgU4FWjxGXJy5YTLYGPe3
        XBW26mK2y8vgucmfBL4lglsbpQ==
X-Google-Smtp-Source: APBJJlGY4P/LgBLx4iQxqLFZd6P0VS5vniPk5QGjZeNHVPESPlAbrax90FYrqQADYpl06F0vGzg78Q==
X-Received: by 2002:a05:6870:15c7:b0:1b0:2506:8d21 with SMTP id k7-20020a05687015c700b001b025068d21mr3675315oad.24.1689980866389;
        Fri, 21 Jul 2023 16:07:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4fa:e795:a6b:cf7f])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b00675701f456csm3480204pfb.54.2023.07.21.16.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 16:07:45 -0700 (PDT)
Date:   Fri, 21 Jul 2023 16:07:43 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Pink Perfect <pinkperfect2021@gmail.com>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <ZLsPv34t2lVgyqNi@google.com>
References: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
 <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
 <20230713105644.49444826@kernel.org>
 <87sf9j3wd1.fsf@kernel.org>
 <ZLlrd4dDz+kA5l18@google.com>
 <87tttx3fci.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tttx3fci.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 21, 2023 at 10:15:25AM +0300, Kalle Valo wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > I'll submit the MAINTAINERS patch if you'd like.
> 
> Sounds very good to me, thank you! Please submit the patch if you can.

Done:
https://lore.kernel.org/linux-wireless/20230721160603.1.Idf0e8025f59c62d73c08960638249b58cf215acc@changeid/

Brian
