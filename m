Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376D112BED7
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2019 21:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL1U0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Dec 2019 15:26:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46416 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1U0g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Dec 2019 15:26:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id k8so23771695otl.13
        for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2019 12:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apGtXbafp8YNvdMDtrKpbKJEIgBKmn9t46TCl1oT4BU=;
        b=lQGjULW44onjhdvRiGu7qpsQxhq+Zv2ozqsWPazj52kfcU0e1Z/czNAvs3gjnyQ5IH
         F4b7C/MszOsFvm9RCjCivNtJLOp6ghEibZthhmeNyANtXpAlhL2i/z5P4gDU+WMmj8ZH
         7ZZn+aYmYti2Gowj9XaIEP14Ry/dst67qr+VnHBbpuanHhRpb9xsdydteHSor9KRNB4A
         OaS1Ky7P5ymhkpgphnA5gaW4B64/s9uvKJCyKQpvPrz7lXadWg8+YWL348jpt+hkhzKF
         UCDld7hBPuoeXfoyfoYo1uUXhh6RK9JSGX1jxlQZvLFga51XyEPR55FkiP7cKElcFiWT
         ge9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apGtXbafp8YNvdMDtrKpbKJEIgBKmn9t46TCl1oT4BU=;
        b=jljR68yMhCVw+fKS+Ieq37/IUpU8uWjkpqsgvltILbTYxFD+rluMlmQTK91mmssPJG
         9hSZ+zsM9G/OvXF1yjaGdXwbMYEgb3Dv2PbSpPqqXDDhZJXGS1+qIxQwXPzrLk/3gzYq
         BVy5IdZwk95V55kq0h6jTKH5K+vowwYLtlEps97xUNx6VGT7auqT7u0yZhZ2FfKIPtMy
         yBd7sCRZ8IOZRROfNYdAZFyyg3ODfY9vLgKXq9GQUHzzlkdaaJXibxBt9Wsx89MO8AEs
         UklEFgrrjuhp1GzcdvjkzdSm8AcTqLkRC0mTi75Yk5GiuQZ1e9xPxdP4VUfyPUZMJdYL
         WjsQ==
X-Gm-Message-State: APjAAAVhk4l1Xq3x+pekpxUIyv1JsUBUJ3YRj+CCk40+xcV9y5R9OLiB
        hjURhhVI6iPsEhEeAX1qkg55KQhFl3l/1IAznuk=
X-Google-Smtp-Source: APXvYqwQzoz3gejHBIxVpynfYfgYQ89jx/+GBr3nYDN6C82o4a0p5zQIw1/tkp4jTJeIxGXiwgUeaD8IMTUpeWQqwjE=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr48908051otp.177.1577564795203;
 Sat, 28 Dec 2019 12:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20191220115638.1299888-4-luca@coelho.fi> <20191223093250.1445654-1-luca@coelho.fi>
In-Reply-To: <20191223093250.1445654-1-luca@coelho.fi>
From:   Justin Capella <justincapella@gmail.com>
Date:   Sat, 28 Dec 2019 12:26:24 -0800
Message-ID: <CAMrEMU-qALUNn3njYxomD_2GYUV3MHSTuwjfrC_AFaWybqi3qw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] iwlwifi: pcie: work around DMA hardware bug
To:     Luca Coelho <luca@coelho.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Would using phys+len & ~dev->dma_mask work in place of the 4g boundary check

On Mon, Dec 23, 2019 at 1:33 AM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> There's a hardware bug in the flow handler (DMA engine), if the
> address + len of some TB wraps around a 2^32 boundary, the carry
> bit is then carried over into the next TB.
>
> Work around this by copying the data to a new page when we find
> this situation, and then copy it in a way that we cannot hit the
> very end of the page.
>
> To be able to free the new page again later we need to chain it
> to the TSO page, use the last pointer there to make sure we can
> never use the page fully for DMA, and thus cannot cause the same
> overflow situation on this page.
>
> This leaves a few potential places (where we didn't observe the
> problem) unaddressed:
>  * The second TB could reach or cross the end of a page (and thus
>    2^32) due to the way we allocate the dev_cmd for the header
>  * For host commands, a similar thing could happen since they're
>    just kmalloc().
> We'll address these in further commits.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>
> In v2:
>    * fix a warning when compiling on 32-bit platforms [kbuildbot].
>
>
> .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 179 +++++++++++++++---
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  28 ++-
>  2 files changed, 176 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> index 494a8864368d..8abadfbc793a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> @@ -213,6 +213,16 @@ static void iwl_pcie_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
>         }
>  }
>
> +/*
> + * We need this inline in case dma_addr_t is only 32-bits - since the
> + * hardware is always 64-bit, the issue can still occur in that case,
> + * so use u64 for 'phys' here to force the addition in 64-bit.
> + */
> +static inline bool crosses_4g_boundary(u64 phys, u16 len)
> +{
> +       return upper_32_bits(phys) != upper_32_bits(phys + len);
> +}
> +
>  static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
>                                 struct iwl_tfh_tfd *tfd, dma_addr_t addr,
>                                 u16 len)
> @@ -240,6 +250,107 @@ static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
>         return idx;
>  }
>
> +static struct page *get_workaround_page(struct iwl_trans *trans,
> +                                       struct sk_buff *skb)
> +{
> +       struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
> +       struct page **page_ptr;
> +       struct page *ret;
> +
> +       page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
> +
> +       ret = alloc_page(GFP_ATOMIC);
> +       if (!ret)
> +               return NULL;
> +
> +       /* set the chaining pointer to the previous page if there */
> +       *(void **)(page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
> +       *page_ptr = ret;
> +
> +       return ret;
> +}
> +
> +/*
> + * Add a TB and if needed apply the FH HW bug workaround;
> + * meta != NULL indicates that it's a page mapping and we
> + * need to dma_unmap_page() and set the meta->tbs bit in
> + * this case.
> + */
> +static int iwl_pcie_gen2_set_tb_with_wa(struct iwl_trans *trans,
> +                                       struct sk_buff *skb,
> +                                       struct iwl_tfh_tfd *tfd,
> +                                       dma_addr_t phys, void *virt,
> +                                       u16 len, struct iwl_cmd_meta *meta)
> +{
> +       dma_addr_t oldphys = phys;
> +       struct page *page;
> +       int ret;
> +
> +       if (unlikely(dma_mapping_error(trans->dev, phys)))
> +               return -ENOMEM;
> +
> +       if (likely(!crosses_4g_boundary(phys, len))) {
> +               ret = iwl_pcie_gen2_set_tb(trans, tfd, phys, len);
> +
> +               if (ret < 0)
> +                       goto unmap;
> +
> +               if (meta)
> +                       meta->tbs |= BIT(ret);
> +
> +               ret = 0;
> +               goto trace;
> +       }
> +
> +       /*
> +        * Work around a hardware bug. If (as expressed in the
> +        * condition above) the TB ends on a 32-bit boundary,
> +        * then the next TB may be accessed with the wrong
> +        * address.
> +        * To work around it, copy the data elsewhere and make
> +        * a new mapping for it so the device will not fail.
> +        */
> +
> +       if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
> +               ret = -ENOBUFS;
> +               goto unmap;
> +       }
> +
> +       page = get_workaround_page(trans, skb);
> +       if (!page) {
> +               ret = -ENOMEM;
> +               goto unmap;
> +       }
> +
> +       memcpy(page_address(page), virt, len);
> +
> +       phys = dma_map_single(trans->dev, page_address(page), len,
> +                             DMA_TO_DEVICE);
> +       if (unlikely(dma_mapping_error(trans->dev, phys)))
> +               return -ENOMEM;
> +       ret = iwl_pcie_gen2_set_tb(trans, tfd, phys, len);
> +       if (ret < 0) {
> +               /* unmap the new allocation as single */
> +               oldphys = phys;
> +               meta = NULL;
> +               goto unmap;
> +       }
> +       IWL_WARN(trans,
> +                "TB bug workaround: copied %d bytes from 0x%llx to 0x%llx\n",
> +                len, (unsigned long long)oldphys, (unsigned long long)phys);
> +
> +       ret = 0;
> +unmap:
> +       if (meta)
> +               dma_unmap_page(trans->dev, oldphys, len, DMA_TO_DEVICE);
> +       else
> +               dma_unmap_single(trans->dev, oldphys, len, DMA_TO_DEVICE);
> +trace:
> +       trace_iwlwifi_dev_tx_tb(trans->dev, skb, virt, phys, len);
> +
> +       return ret;
> +}
> +
>  static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
>                                      struct sk_buff *skb,
>                                      struct iwl_tfh_tfd *tfd, int start_len,
> @@ -327,6 +438,11 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
>                         dev_kfree_skb(csum_skb);
>                         goto out_err;
>                 }
> +               /*
> +                * No need for _with_wa, this is from the TSO page and
> +                * we leave some space at the end of it so can't hit
> +                * the buggy scenario.
> +                */
>                 iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb_len);
>                 trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
>                                         tb_phys, tb_len);
> @@ -338,16 +454,18 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
>
>                 /* put the payload */
>                 while (data_left) {
> +                       int ret;
> +
>                         tb_len = min_t(unsigned int, tso.size, data_left);
>                         tb_phys = dma_map_single(trans->dev, tso.data,
>                                                  tb_len, DMA_TO_DEVICE);
> -                       if (unlikely(dma_mapping_error(trans->dev, tb_phys))) {
> +                       ret = iwl_pcie_gen2_set_tb_with_wa(trans, skb, tfd,
> +                                                          tb_phys, tso.data,
> +                                                          tb_len, NULL);
> +                       if (ret) {
>                                 dev_kfree_skb(csum_skb);
>                                 goto out_err;
>                         }
> -                       iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb_len);
> -                       trace_iwlwifi_dev_tx_tb(trans->dev, skb, tso.data,
> -                                               tb_phys, tb_len);
>
>                         data_left -= tb_len;
>                         tso_build_data(skb, &tso, tb_len);
> @@ -381,6 +499,11 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx_amsdu(struct iwl_trans *trans,
>
>         tb_phys = iwl_pcie_get_first_tb_dma(txq, idx);
>
> +       /*
> +        * No need for _with_wa, the first TB allocation is aligned up
> +        * to a 64-byte boundary and thus can't be at the end or cross
> +        * a page boundary (much less a 2^32 boundary).
> +        */
>         iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, IWL_FIRST_TB_SIZE);
>
>         /*
> @@ -425,24 +548,19 @@ static int iwl_pcie_gen2_tx_add_frags(struct iwl_trans *trans,
>         for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>                 const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
>                 dma_addr_t tb_phys;
> -               int tb_idx;
> +               unsigned int fragsz = skb_frag_size(frag);
> +               int ret;
>
> -               if (!skb_frag_size(frag))
> +               if (!fragsz)
>                         continue;
>
>                 tb_phys = skb_frag_dma_map(trans->dev, frag, 0,
> -                                          skb_frag_size(frag), DMA_TO_DEVICE);
> -
> -               if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
> -                       return -ENOMEM;
> -               tb_idx = iwl_pcie_gen2_set_tb(trans, tfd, tb_phys,
> -                                             skb_frag_size(frag));
> -               trace_iwlwifi_dev_tx_tb(trans->dev, skb, skb_frag_address(frag),
> -                                       tb_phys, skb_frag_size(frag));
> -               if (tb_idx < 0)
> -                       return tb_idx;
> -
> -               out_meta->tbs |= BIT(tb_idx);
> +                                          fragsz, DMA_TO_DEVICE);
> +               ret = iwl_pcie_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
> +                                                  skb_frag_address(frag),
> +                                                  fragsz, out_meta);
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> @@ -470,6 +588,11 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
>         /* The first TB points to bi-directional DMA data */
>         memcpy(&txq->first_tb_bufs[idx], dev_cmd, IWL_FIRST_TB_SIZE);
>
> +       /*
> +        * No need for _with_wa, the first TB allocation is aligned up
> +        * to a 64-byte boundary and thus can't be at the end or cross
> +        * a page boundary (much less a 2^32 boundary).
> +        */
>         iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, IWL_FIRST_TB_SIZE);
>
>         /*
> @@ -499,26 +622,30 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
>         tb2_len = skb_headlen(skb) - hdr_len;
>
>         if (tb2_len > 0) {
> +               int ret;
> +
>                 tb_phys = dma_map_single(trans->dev, skb->data + hdr_len,
>                                          tb2_len, DMA_TO_DEVICE);
> -               if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
> +               ret = iwl_pcie_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
> +                                                  skb->data + hdr_len, tb2_len,
> +                                                  NULL);
> +               if (ret)
>                         goto out_err;
> -               iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb2_len);
> -               trace_iwlwifi_dev_tx_tb(trans->dev, skb, skb->data + hdr_len,
> -                                       tb_phys, tb2_len);
>         }
>
>         if (iwl_pcie_gen2_tx_add_frags(trans, skb, tfd, out_meta))
>                 goto out_err;
>
>         skb_walk_frags(skb, frag) {
> +               int ret;
> +
>                 tb_phys = dma_map_single(trans->dev, frag->data,
>                                          skb_headlen(frag), DMA_TO_DEVICE);
> -               if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
> +               ret = iwl_pcie_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
> +                                                  frag->data,
> +                                                  skb_headlen(frag), NULL);
> +               if (ret)
>                         goto out_err;
> -               iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, skb_headlen(frag));
> -               trace_iwlwifi_dev_tx_tb(trans->dev, skb, frag->data,
> -                                       tb_phys, skb_headlen(frag));
>                 if (iwl_pcie_gen2_tx_add_frags(trans, frag, tfd, out_meta))
>                         goto out_err;
>         }
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> index 2d1758031a0a..ba37b780dec4 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> @@ -624,12 +624,18 @@ void iwl_pcie_free_tso_page(struct iwl_trans_pcie *trans_pcie,
>                             struct sk_buff *skb)
>  {
>         struct page **page_ptr;
> +       struct page *next;
>
>         page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
> +       next = *page_ptr;
> +       *page_ptr = NULL;
>
> -       if (*page_ptr) {
> -               __free_page(*page_ptr);
> -               *page_ptr = NULL;
> +       while (next) {
> +               struct page *tmp = next;
> +
> +               next = *(void **)(page_address(next) + PAGE_SIZE -
> +                                 sizeof(void *));
> +               __free_page(tmp);
>         }
>  }
>
> @@ -2067,8 +2073,18 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
>         if (!p->page)
>                 goto alloc;
>
> -       /* enough room on this page */
> -       if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE)
> +       /*
> +        * Check if there's enough room on this page
> +        *
> +        * Note that we put a page chaining pointer *last* in the
> +        * page - we need it somewhere, and if it's there then we
> +        * avoid DMA mapping the last bits of the page which may
> +        * trigger the 32-bit boundary hardware bug.
> +        *
> +        * (see also get_workaround_page() in tx-gen2.c)
> +        */
> +       if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE -
> +                          sizeof(void *))
>                 goto out;
>
>         /* We don't have enough room on this page, get a new one. */
> @@ -2079,6 +2095,8 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
>         if (!p->page)
>                 return NULL;
>         p->pos = page_address(p->page);
> +       /* set the chaining pointer to NULL */
> +       *(void **)(page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
>  out:
>         *page_ptr = p->page;
>         get_page(p->page);
> --
> 2.24.0
>
