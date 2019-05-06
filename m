Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F226B151A0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEFQdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 12:33:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39494 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfEFQb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 12:31:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id z124so3478591lfd.6
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wagpSFeZjiSYROHr7BDwlgLPN1h4XicGjvtdDBu+n9c=;
        b=KvPbQf5ojgfmelT2YV7IcRcMLqR9GapZoa4g4+qAbBdlWZSTS1KiFKUTm+kBQd/Byr
         JffruthirxsW3We/MAlRPJMY55Ee0Ir8Map29okquwu2v9cSocVP227PFBp0i55V9WR7
         lw4BhqMJYwuXp5kBp0Kr0LUpTLTMdEEQBvjog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wagpSFeZjiSYROHr7BDwlgLPN1h4XicGjvtdDBu+n9c=;
        b=LPEml8il9DNlMwzSfs/08Mhd2dxsHtc+IoCby/zzU89N8DA6qTs+qd1xkAJkXRzUWV
         Sju2cQLgSL62asYsmqfzQlmYJ9FAENktlTxeEiQ/vHveQsCe1HtMc0OW0Ww48oco5GTY
         0vuNQvblRVsBz5j8H3OZemYmAZMAMmY3DDbUeTq9t4hlJhJws6iY4eqa9qqdkw7oIni6
         H1jDnqJzBgr0FWJuuSVqQ5t3i4qghnlGAbPjSylcAvwOXPsLWyL7B3EbZktw4Jcjkih9
         7z2cdzpgnxGujg10VKnnuYeqhakm+OFNiU8eGKUmgv7toXAf82cCyfQu9edfHO9Sm+ul
         ic+Q==
X-Gm-Message-State: APjAAAX+DlkCTVd1fnyHZh1I4GjdN3OrGoFe95QnC7pyOip0TJ76+V4l
        GvWU2ufd9XNx5vrkwgj/Mi50U0CE4M4=
X-Google-Smtp-Source: APXvYqyXkyXoEPyg9nnIBAvx0uwzWEVV8DAPaQokOo4lhZxgrxfAwZn75E2wdnY1dkPPZaRz+9K5gA==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr13107457lfd.159.1557160287071;
        Mon, 06 May 2019 09:31:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id n12sm1904483lfk.95.2019.05.06.09.31.25
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:31:25 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id o16so9608381lfl.7
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 09:31:25 -0700 (PDT)
X-Received: by 2002:a19:4bc5:: with SMTP id y188mr12592750lfa.24.1557160285265;
 Mon, 06 May 2019 09:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190506142603.1746-1-govinds@codeaurora.org>
In-Reply-To: <20190506142603.1746-1-govinds@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 May 2019 09:31:13 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNuf5=Q4v8HqtM2xGvqN1c_0q9mBNo9wdO3pRcBBqe2oQ@mail.gmail.com>
Message-ID: <CA+ASDXNuf5=Q4v8HqtM2xGvqN1c_0q9mBNo9wdO3pRcBBqe2oQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ath10k: Enable MSA region dump support for WCN3990
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 6, 2019 at 7:26 AM Govind Singh <govinds@codeaurora.org> wrote:
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c

> @@ -1586,6 +1587,72 @@ static int ath10k_hw_power_off(struct ath10k *ar)
>         return ret;
>  }
>
> +static void ath10k_msa_dump_memory(struct ath10k *ar,
> +                                  struct ath10k_fw_crash_data *crash_data)
> +{
> +       struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +       const struct ath10k_hw_mem_layout *mem_layout;
> +       const struct ath10k_mem_region *current_region;
> +       struct ath10k_dump_ram_data_hdr *hdr;
> +       size_t buf_len;
> +       u8 *buf;
> +
> +       lockdep_assert_held(&ar->data_lock);

I believe that's the wrong lock now. See below.

> +
> +       if (!crash_data && !crash_data->ramdump_buf)
> +               return;
> +
> +       mem_layout = ath10k_coredump_get_mem_layout(ar);
> +       if (!mem_layout)
> +               return;
> +
> +       current_region = &mem_layout->region_table.regions[0];
> +
> +       buf = crash_data->ramdump_buf;
> +       buf_len = crash_data->ramdump_buf_len;
> +       memset(buf, 0, buf_len);
> +
> +       /* Reserve space for the header. */
> +       hdr = (void *)buf;
> +       buf += sizeof(*hdr);
> +       buf_len -= sizeof(*hdr);
> +
> +       hdr->region_type = cpu_to_le32(current_region->type);
> +       hdr->start = cpu_to_le32(ar_snoc->qmi->msa_va);
> +       hdr->length = cpu_to_le32(ar_snoc->qmi->msa_mem_size);
> +
> +       if (current_region->len < ar_snoc->qmi->msa_mem_size) {
> +               memcpy(buf, ar_snoc->qmi->msa_va, current_region->len);
> +               ath10k_warn(ar, "msa dump length is less than msa size %x, %x\n",
> +                           current_region->len, ar_snoc->qmi->msa_mem_size);
> +       } else {
> +               memcpy(buf, ar_snoc->qmi->msa_va, ar_snoc->qmi->msa_mem_size);
> +       }
> +}
> +
> +void ath10k_snoc_fw_crashed_dump(struct ath10k *ar)
> +{
> +       struct ath10k_fw_crash_data *crash_data;
> +       char guid[UUID_STRING_LEN + 1];
> +
> +       spin_lock_bh(&ar->data_lock);
> +
> +       ar->stats.fw_crash_counter++;
> +
> +       crash_data = ath10k_coredump_new(ar);

This will (for good reason) spit a lockdep warning after this, I think:

38faed150438 ath10k: perform crash dump collection in workqueue

You need to hold 'dump_mutex' now. I believe you only need to hold
'data_lock' for the sake of the crash counter.

Brian

> +
> +       if (crash_data)
> +               scnprintf(guid, sizeof(guid), "%pUl", &crash_data->guid);
> +       else
> +               scnprintf(guid, sizeof(guid), "n/a");
> +
> +       ath10k_err(ar, "firmware crashed! (guid %s)\n", guid);
> +       ath10k_print_driver_info(ar);
> +       ath10k_msa_dump_memory(ar, crash_data);
> +
> +       spin_unlock_bh(&ar->data_lock);
> +}
