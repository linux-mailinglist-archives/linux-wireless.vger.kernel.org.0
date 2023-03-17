Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2529A6BE006
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 05:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCQEK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 00:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCQEKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 00:10:46 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD1C66F
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 21:10:45 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id m5so2547749uae.11
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 21:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679026244;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PkMQ5wHIGZcuAOofyhWRmm0uU6+B5cY9SowoxLh++1U=;
        b=cZlOP6okNbExmWpCzllzyaLZNvHH7d0WQKk5Tu5dB3xvjOqpp8N21e8e5faAG3TS3P
         g4MZ7Jb1ShuFDyon4+Ykw8fBnjU13fK2BvQIhTJzh2K5bSrW/nXn/Cp4oeDwVPrIaqQT
         yAFj87tU/N3ZMlwccZ6YyjVVIqoTHmJSRX1F0vA9k3KBE06Isr94LeA+fH5MEM9f+9l9
         ZJX9a+D08fR4ljLyxaVCfxjMw5xELqElV2dcJ3KarOA1S1ss7Yikb01FLo4I5ryAzrHX
         oy2bSGvYJIINhk423FvVwjWbtGxmEbxBO114C9qTruHOUkZ5HgQdBrJsqwhhx/XDMVCg
         VlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679026244;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkMQ5wHIGZcuAOofyhWRmm0uU6+B5cY9SowoxLh++1U=;
        b=D3aoxBN3ZIponZvbYIvHHZQluO0jkEAx4jwlnkfbUz4ncEJL36mNHBhcQJdru2qxGH
         8cmjoQ5skgKbY+O7WMz51y2B8TDkjMUhA9+QrxKEZaPu48sJqOBLZAjvILJAhly7lu2/
         SWnYXwg1mLcA67KsulB32wXrwPz9U2Z51RfOy3mAaGlPAxgtAN9RgkczbzSITkT8Skjm
         2wTqM9J4TNNWy34xtknSquOvYfTMc5CQ9FxdsTQx35Hscwd+ENDPjW3xmU+ceZRHn/5g
         GIP9ObxgkM6AvSxXHyIBK0OL2cFDvY6uU2fHx5kZBpNh1AhOA5u1WHm3G+LXTnYRdf+c
         EAsA==
X-Gm-Message-State: AO0yUKXQNiiXn7wPq8Ex3Fl4PBkSbQ/c9rAnYzG2p3gJ4EFavisnafC7
        bif1gSOhyCFKYXWK/goPSkYnJ+zNtGoOad7h8xssZ9Lf5g==
X-Google-Smtp-Source: AK7set+dX/ZkSAdStsQ7sm6gKVrXWPFCHH/WsezwCcnFmmiaqbmCub1vnV6nd38kMGB32g6zfwWQOzKtHsJyReaY2UU=
X-Received: by 2002:a1f:a9c7:0:b0:401:73f4:dfe with SMTP id
 s190-20020a1fa9c7000000b0040173f40dfemr29438961vke.3.1679026244005; Thu, 16
 Mar 2023 21:10:44 -0700 (PDT)
MIME-Version: 1.0
From:   Sudeep R K <a0p0p0u@gmail.com>
Date:   Fri, 17 Mar 2023 00:10:33 -0400
Message-ID: <CANA1Jzc=A1RNRkX7VRdgEn7nywokyG3=jJfA_LNbXygOZEwJaQ@mail.gmail.com>
Subject: 64bit Support for QCA6174 in Linux
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, Good day to you!

I have a problem with one of my legacy patches

shared/arrisxi6/kernel-source/drivers/net/wireless/ath/ath10k/pmem.c:165:16:
error: 'PAGE_KERNEL_NOCACHE' undeclared (first use in this function);
did you mean 'PAGE_KERNEL_ROX'?
15:06:24 |   165 |        VM_MAP, PAGE_KERNEL_NOCACHE)

After fixing the build issue,  started seeing runtime issues.
2023 Mar 08 14:21:48.093818 kernel:  ath10k_pci 0000:01:00.0: Failed
to get pcie state addr: -16
2023 Mar 08 14:21:48.094193 kernel:  ath10k_pci 0000:01:00.0: failed
to setup init config: -16
2023 Mar 08 14:21:48.094535 kernel:  ath10k_pci 0000:01:00.0: could
not power on hif bus (-16)
2023 Mar 08 14:21:48.094875 kernel:  ath10k_pci 0000:01:00.0: could
not probe fw (-16)

When I checked the source of the problem, it is from the following lines of code

int ath10k_pci_init_config(struct ath10k *ar)
{
struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
u32 interconnect_targ_addr;
u32 pcie_state_targ_addr = 0;
u32 pipe_cfg_targ_addr = 0;
u32 svc_to_pipe_map = 0;
u32 pcie_config_flags = 0;
u32 ealloc_value;
u32 ealloc_targ_addr;
u32 flag2_value;
u32 flag2_targ_addr;
int ret = 0;

/* Download to Target the CE Config and the service-to-CE map */
interconnect_targ_addr =
host_interest_item_address(HI_ITEM(hi_interconnect_state));

/* Supply Target-side CE configuration */
ret = ath10k_pci_diag_read32(ar, interconnect_targ_addr,
     &pcie_state_targ_addr);
if (ret != 0) {
ath10k_err(ar, "Failed to get pcie state addr: %d\n", ret);
return ret;
}

Looks like  ath10k_pci_diag_read32 may be limited to 32 bit
mode(please correct me if I am wrong).
1) Will this code work under 64 bit mode?
2)Does ath10k support 64 bit in general?  Is there any documented
support for 64 bit in ath10k for QCA6174?

Thanks a lot for your responses
Sudeep R K
