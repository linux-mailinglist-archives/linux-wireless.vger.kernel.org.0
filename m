Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C94FFB5A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiDMQeC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Apr 2022 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiDMQeB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Apr 2022 12:34:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413BC5EDCF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 09:31:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id bb38so1761717qtb.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=HBhDOEjfV2hkoUxsv2+Y0l8LOqOCdnEetZj+12oD488=;
        b=ISZBymi2znD8YEYFvdLqA3rFbWxU7B6lTtgW0VK0jlWZIgvm+ZoFDRw8w80qrAKhYo
         3lK4N0hRQYEmLGX6V3KBxLw2AfrWfpQU2R4MN1LuyTEkAscOUF4oENr67yILubOnTHxY
         poL4+JQ3y9V01p7q5vrXufWYqErgQKMRwLMiDkKy/7NuCu1S/G5ij9WqAcLfGw/8AL2N
         +vXewdATzJyL+4P5hU2vAsEgQ91gk312PTkM2zjW0zvoSG+oC/Ft3Vm7KzhN7wJh4scg
         sRprIh2WcwWmTZgfaz3395J2jO692JaEVRsjq057nhzPpDxXUc9SB+3lx+jzsyMWj+oO
         5K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HBhDOEjfV2hkoUxsv2+Y0l8LOqOCdnEetZj+12oD488=;
        b=W3g4Aq6wA8OBiVQGJJhQnopRCYXVIX+9FNh+SvL/LNXEgCbWOM7B9vn3fw6gi0gKjM
         2MczhZSPLlLQfz3C9O3Cn31Hywtn5Bt1wHE9tSjS/NH56rh1eTDcTXOBWkT3UGNuNd3o
         RRZppuADWnVc2jmHaOGjbzRnCc4ceOXbok6CRBpmPTKuyax5P6nd8cQ9bZvTzzV+BpUT
         KmqqyB+P8/higq9sjTQSADnzLB8I4D12HXiLW+anOg4xpl3vVrQHkwjOMMQjo7sdK8Uh
         bTOPrXDG4cdHbFENNWfbF2ethdLyjyBKS4nySjqtmtU161qcT2FoOtlytF1cw637Wb3e
         xX9Q==
X-Gm-Message-State: AOAM530Lz5MlMdr2vaPX3Hcj8R7bqxi8M9EjJTgZ7nwn7pFooOxY25m2
        kl9d7w3AsD1RRS1FvkaTzr1daXeLOE30wFW9cSxLXcn1ojOKsw==
X-Google-Smtp-Source: ABdhPJzuPPjbBHrydYafUyQi0ZjC1ZVLszLdvSh/NaqNRp/8NIzObvc5PifCliszLV04NQXhMAZrDEFwfqUTMh3lsxg=
X-Received: by 2002:ac8:6693:0:b0:2ed:964:c268 with SMTP id
 d19-20020ac86693000000b002ed0964c268mr7735827qtp.459.1649867499231; Wed, 13
 Apr 2022 09:31:39 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rogers <crogers122@gmail.com>
Date:   Wed, 13 Apr 2022 12:31:28 -0400
Message-ID: <CAC4Yorhi_Zf-xcSJFOsJja-ZdLJYh6V-_hfkidzfQJ_+HeHX1Q@mail.gmail.com>
Subject: iwlwifi fw reset handshake
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In commit 906d4eb84408a4bfd63eef0de4f1bd5262f73ac0, a firmware reset
handshake was introduced to iwlwifi. This code looks for the
MSIX_HW_INT_CAUSES_REG_RESET_DONE interrupt in
iwl_pcie_irq_msix_handler in rx.c, but it does not appear to handle
anything along the MSI path.

My environment is:
- AX210 card, xen pci passthrough in MSI mode
- linux v5.15.32

Based on some testing I've done, the wait_event_timeout in
pcie/trans-gen2.c always times out.  The result is the "firmware
didn't ACK the reset - continue anyway" message and a dump before it
continues on.  Is the reset handshake something that should be handled
on the MSI path? Given what's defined in iwl-csr.h, I'm not sure how
to listen for a response from the card to wake_up the fw_reset_waitq
like the MSI-X path.

Thanks for your time.

Chris
